# Resource Group
module "resource_group" {
  source   = "./modules/resource_group"
  name     = "rg-warp-one-${local.environment}"
  location = local.location
}

# Key Vault
module "keyvault" {
  source              = "./modules/keyvault"
  name                = "kv-warp-one-${local.environment}"
  resource_group_name = module.resource_group.resource_group_name  
  location            = module.resource_group.resource_group_location
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = data.azurerm_client_config.current.object_id
  secret_permissions  = ["get", "list", "set", "delete"]
  key_permissions     = ["get", "list", "create"]
  certificate_permissions = ["get", "list"]
  tags = {
    environment = local.environment
    project     = "warp-one"
  }
}

# DNS Zone
module "dns" {
  source              = "./modules/dns"
  dns_zone_name       = "princetonstrong.online"
  resource_group_name = module.resource_group.name
  a_records = [
    {
      name       = "www"
      ip_address = "192.0.2.1"  # Example IP address
    }
  ]
  cname_records = [
    {
      name   = "blog"
      target = "blog.princetonstrong.online"
    }
  ]
  ttl = 3600  # 1 hour TTL
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
  source              = "./modules/acr"
  name                = "acr-warp-one-${local.environment}"
  location            = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name  
}

# AKS Cluster
module "aks" {
  source              = "./modules/aks"
  name                = "aks-warp-one-${local.environment}"
  location            = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  dns_prefix          = "akswarpone"
  kubernetes_version  = "1.22.0"
  node_count          = 2
  vm_size             = "Standard_DS2_v2"
  rbac_enabled        = true
  azure_policy_enabled = false
  log_analytics_workspace_id = var.log_analytics_workspace_id
  app_gateway_id      = module.application_gateway.app_gateway_id
  acr_id              = module.acr.acr_id  
  tags = {
    environment = local.environment
    project     = "warp-one"
  }
}

# Argo CD Deployment
module "argocd" {
  source          = "./modules/argocd"
  name            = "argocd"
  namespace       = "argocd"
  argocd_url      = "argocd.princetonstrong.online"
  argocd_tls_secret = "argocd-tls-secret"
}

# Cert-Manager
module "cert_manager" {
  source          = "./modules/cert-manager"
  name            = "cert-manager"
  namespace       = "cert-manager"
}
