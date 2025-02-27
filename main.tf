terraform {
  required_version = ">= 1.2.0"
}

# Resource Group
module "resource_group" {
  source   = "./modules/resource_group"
  name     = "rg-warp-one-${local.environment}"
  location = local.location
}

# Key Vault
module "keyvault" {
  source             = "./modules/keyvault"
  name               = "kv-warp-one-${local.environment}"
  resource_group_name = module.resource_group.name
  location           = module.resource_group.location
  sku_name           = "standard"
  tenant_id          = data.azurerm_client_config.current.tenant_id
  object_id          = data.azurerm_client_config.current.object_id
  secret_permissions = ["get", "list", "set", "delete"]
  key_permissions    = ["get", "list", "create"]
  certificate_permissions = ["get", "list"]
  tags               = {
    environment = local.environment
    project     = "warp-one"
  }
}

# DNS Zone
module "dns" {
  source         = "./modules/dns"
  dns_zone_name  = var.dns_zone_name
  resource_group = module.resource_group.name
}

# Azure Container Registry
module "acr" {
  source              = "./modules/acr"
  name                = "acr-warp-one-${local.environment}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  sku                 = "Premium"
  admin_enabled       = false
  tags = {
    environment = local.environment
    project     = "warp-one"
  }
}

# AKS Cluster
module "aks" {
  source         = "./modules/aks"
  name           = "aks-warp-one-${local.environment}"
  resource_group_name = module.resource_group.name
  location       = module.resource_group.location
  dns_prefix     = "akswarp-${local.environment}"
  kubernetes_version = "1.22.5"  # Update as necessary
  node_count     = 3
  vm_size        = "Standard_DS2_v2"
  log_analytics_workspace_id = module.log_analytics.workspace_id  # If you use Log Analytics
  acr_id          = module.acr.id  # Pass ACR ID for role assignment
}

# Argo CD Deployment
module "argocd" {
  source       = "./modules/argocd"
  repo_url     = "https://argoproj.github.io/argo-helm"
  namespace    = "argocd"
  cluster_name = module.aks.name
}
