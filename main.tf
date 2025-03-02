# Resource Group
module "resource_group" {
  source   = "./modules/resource_group"
  name     = "rg-${local.environment}"
  location = local.location
}

# Networking
module "network" {
  source                        = "./modules/network"
  location                      = module.resource_group.resource_group_location
  resource_group_name           = module.resource_group.resource_group_name
  vnet_name                     = "vnet-${local.environment}"
  vnet_address_space            = ["10.0.0.0/16"]
  aks_subnet_name               = "aks-subnet"
  aks_subnet_address_prefixes   = ["10.0.1.0/24"]
  appgw_subnet_name             = "appgw-subnet"
  appgw_subnet_address_prefixes = ["10.0.2.0/24"]
  nsg_name                      = "nsg-${local.environment}"
  appgw_public_ip_name          = "appgw-public-ip-${local.environment}"
}

# Secrets & Key Vault
module "secrets_management" {
  source              = "./modules/secrets_management"
  name                = "kv-${local.environment}"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  object_id           = data.azurerm_client_config.current.object_id
  tenant_id           = data.azurerm_client_config.current.tenant_id

  ssl_certificate_name = "appgw-ssl-cert"
  domain_name          = "princetonstrong.online"
  validity_in_months   = 12

  secret_name  = var.secret_name
  secret_value = var.secret_value
}

# DNS Zone
module "dns" {
  source              = "./modules/dns"
  dns_zone_name       = "princetonstrong.online"
  resource_group_name = module.resource_group.resource_group_name
}

# Log Analytics Workspace
module "log_analytics" {
  source                = "./modules/log_analytics"
  name                  = "log-${local.environment}"
  location              = module.resource_group.resource_group_location
  resource_group_name   = module.resource_group.resource_group_name
  sku                   = "PerGB2018"
  retention_in_days     = 30
  enable_aks_monitoring = true
  tags = {
    environment = local.environment
    project     = "phoenix"
  }
}

# Application Gateway 
module "application_gateway" {
  source                    = "./modules/application_gateway"
  name                      = "appgw-${local.environment}"
  location                  = module.resource_group.resource_group_location
  resource_group_name       = module.resource_group.resource_group_name
  public_ip_address_id      = module.network.appgw_public_ip_id  
  subnet_id                 = module.network.appgw_subnet_id
  ssl_certificate_name      = module.secrets_management.ssl_certificate_name
  ssl_certificate_secret_id = module.secrets_management.certificate_secret_id
}

# Azure Container Registry (ACR)
module "acr" {
  source              = "./modules/acr"
  name                = "bozeman"
  location            = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
}

# AKS
module "aks" {
  source                     = "./modules/aks"
  name                       = "aks-warp-one-${local.environment}"
  location                   = module.resource_group.resource_group_location
  resource_group_name        = module.resource_group.resource_group_name
  dns_prefix                 = "akswarpone"
  kubernetes_version         = "1.30.5"
  node_count                 = 2  
  vm_size                    = "Standard_DS2_v2"  
  rbac_enabled               = true  
  log_analytics_workspace_id = module.log_analytics.log_analytics_workspace_id  
  acr_id                     = module.acr.acr_id  
  appgw_subnet_id            = module.network.appgw_subnet_id  
}


