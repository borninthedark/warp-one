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
}

# DNS Zone
module "dns" {
  source              = "./modules/dns"
  dns_zone_name       = "princetonstrong.online"
  resource_group_name = module.resource_group.resource_group_name
}

# Public IP for Application Gateway
module "public_ip" {
  source              = "./modules/public_ip"
  name                = "appgw-public-ip-${local.environment}"
  location            = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
}

# Application Gateway
module "application_gateway" {
  source               = "./modules/application_gateway"
  name                 = "appgw-warp-one-${local.environment}"
  location             = module.resource_group.resource_group_location
  resource_group_name  = module.resource_group.resource_group_name
  public_ip_address_id = module.public_ip.public_ip_id
  subnet_id            = var.subnet_id
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
  log_analytics_workspace_id = var.log_analytics_workspace_id
  app_gateway_id             = module.application_gateway.app_gateway_id
  acr_id                     = module.acr.acr_id
}

# Cert Manager
module "cert_manager" {
  source = "./modules/cert-manager"
  name   = "cert-manager"
  namespace = "cert-manager"

  kube_config_host  = module.aks.aks_kube_config.host
  kube_config_ca    = module.aks.aks_kube_config.cluster_ca_certificate
  kube_config_token = module.aks.aks_kube_config.token
}

# ArgoCD
module "argocd" {
  source    = "./modules/argocd"
  name      = "argocd"
  namespace = "argocd"

  kube_config_host  = module.aks.aks_kube_config.host
  kube_config_ca    = module.aks.aks_kube_config.cluster_ca_certificate
  kube_config_token = module.aks.aks_kube_config.token
}
