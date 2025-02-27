# Resource Group
module "resource_group" {
  source   = "./modules/resource_group"
  name     = "rg-warp-one-${local.environment}"
  location = local.location
}

# Key Vault
module "keyvault" {
  source         = "./modules/keyvault"
  name           = "kv-warp-one-${local.environment}"
  resource_group = module.resource_group.name
  location       = module.resource_group.location
}

# DNS Zone
module "dns" {
  source         = "./modules/dns"
  dns_zone_name  = var.dns_zone_name
  resource_group = module.resource_group.name
}

# Public IP for Application Gateway (If you plan to use AGIC)
module "public_ip" {
  source              = "./modules/public_ip"
  name                = "appgw-public-ip-${local.environment}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  allocation_method   = "Static"   # Static IP for Application Gateway
  sku                  = "Standard"  # Standard SKU for a public IP
  tags = {
    environment = local.environment
    project     = "warp-one"
  }
}

# Application Gateway (AGIC)
module "application_gateway" {
  source              = "./modules/application_gateway"
  name                = "appgw-warp-one-${local.environment}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  public_ip_address_id = module.public_ip.public_ip_id
  subnet_id           = var.subnet_id  # Reference the subnet where the gateway should be deployed
  tags                = {
    environment = local.environment
    project     = "warp-one"
  }
}

# Azure Container Registry (ACR)
module "acr" {
  source         = "./modules/acr"
  name           = "acr-warp-one-${local.environment}"
  resource_group = module.resource_group.name
  location       = module.resource_group.location
}

# AKS Cluster
module "aks" {
  source              = "./modules/aks"
  name                = "aks-warp-one-${local.environment}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  dns_prefix          = "akswarpone"
  kubernetes_version  = "1.22.0"
  node_pool_name      = "default"
  node_count          = 3
  vm_size             = "Standard_DS2_v2"
  os_type             = "Linux"
  rbac_enabled        = true
  azure_policy_enabled = false
  oms_agent_enabled   = true
  log_analytics_workspace_id = var.log_analytics_workspace_id
  app_gateway_id      = module.application_gateway.app_gateway_id  # Link AGIC with the Application Gateway
  tags = {
    environment = local.environment
    project     = "warp-one"
  }
}

# Argo CD Deployment
module "argocd" {
  source       = "./modules/argocd"
  repo_url     = "https://argoproj.github.io/argo-helm"
  namespace    = "argocd"
  cluster_name = module.aks.name
}

