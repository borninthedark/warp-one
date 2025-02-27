provider "azurerm" {
  features {}
}

# Fetch Azure Client Config
data "azurerm_client_config" "current" {}

locals {
  environment = terraform.workspace
  location    = var.location
}

# ✅ Resource Group
module "resource_group" {
  source   = "./modules/resource_group"
  name     = "rg-warp-one-${local.environment}"
  location = local.location
}

# ✅ Networking
module "network" {
  source                    = "./modules/network"
  resource_group_name       = module.resource_group.resource_group_name
  location                  = module.resource_group.resource_group_location
  vnet_name                 = "vnet-warp-one-${local.environment}"
  vnet_address_space        = ["10.0.0.0/16"]
  aks_subnet_name           = "aks-subnet"
  aks_subnet_address_prefixes = ["10.0.1.0/24"]
  appgw_subnet_name         = "appgw-subnet"
  appgw_subnet_address_prefixes = ["10.0.2.0/24"]
  nsg_name                  = "nsg-warp-one-${local.environment}"
  appgw_public_ip_name      = "appgw-public-ip-${local.environment}"
  tags                      = {
    environment = local.environment
    project     = "warp-one"
  }
}

# ✅ Key Vault
module "keyvault" {
  source              = "./modules/keyvault"
  name                = "kv-warp-one-${local.environment}"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = data.azurerm_client_config.current.object_id
}

# ✅ DNS Zone
module "dns" {
  source              = "./modules/dns"
  dns_zone_name       = "princetonstrong.online"
  resource_group_name = module.resource_group.resource_group_name
}

# ✅ Log Analytics Workspace
module "log_analytics" {
  source              = "./modules/log_analytics"
  name                = "log-warp-one-${local.environment}"
  location            = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  enable_aks_monitoring = true
  tags = {
    environment = local.environment
    project     = "warp-one"
  }
}

# ✅ Public IP for Application Gateway
module "public_ip" {
  source              = "./modules/public_ip"
  name                = "appgw-public-ip-${local.environment}"
  location            = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
}

# ✅ Application Gateway
module "application_gateway" {
  source               = "./modules/application_gateway"
  name                 = "appgw-warp-one-${local.environment}"
  location             = module.resource_group.resource_group_location
  resource_group_name  = module.resource_group.resource_group_name
  public_ip_address_id = module.public_ip.public_ip_id
  subnet_id            = module.network.appgw_subnet_id
}

# ✅ Azure Container Registry (ACR)
module "acr" {
  source              = "./modules/acr"
  name                = "acr-warp-one-${local.environment}"
  location            = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
}

# ✅ AKS Cluster
module "aks" {
  source                     = "./modules/aks"
  name                       = "aks-warp-one-${local.environment}"
  location                   = module.resource_group.resource_group_location
  resource_group_name        = module.resource_group.resource_group_name
  dns_prefix                 = "akswarpone"
  kubernetes_version         = "1.22.0"
  node_count                 = 3
  vm_size                    = "Standard_DS2_v2"
  rbac_enabled               = true
  azure_policy_enabled       = false
  log_analytics_workspace_id = module.log_analytics.log_analytics_workspace_id
  app_gateway_id             = module.application_gateway.app_gateway_id
  acr_id                     = module.acr.acr_id
}

# ✅ Cert Manager
module "cert_manager" {
  source = "./modules/cert-manager"
  name   = "cert-manager"
  namespace = "cert-manager"

  kube_config_host  = module.aks.aks_kube_config.host
  kube_config_ca    = module.aks.aks_kube_config.cluster_ca_certificate
  kube_config_token = module.aks.aks_kube_config.token
}

# ✅ ArgoCD
module "argocd" {
  source    = "./modules/argocd"
  name      = "argocd"
  namespace = "argocd"

  kube_config_host  = module.aks.aks_kube_config.host
  kube_config_ca    = module.aks.aks_kube_config.cluster_ca_certificate
  kube_config_token = module.aks.aks_kube_config.token
}


