# Resource Group
module "resource_group" {
  source   = "./modules/resource_group"
  name     = "rg-${local.environment}"
  location = local.location
  tags = {
    environment = local.environment
    project     = "nx"
  }
}

# Networking
module "network" {
  source                        = "./modules/network"
  location                      = module.resource_group.resource_group_location
  resource_group_name           = module.resource_group.resource_group_name
  vnet_name                     = "vnet-${local.environment}"
  vnet_address_space            = ["172.17.1.0/24"]
  aks_subnet_name               = "aks-subnet"
  aks_subnet_address_prefixes   = ["172.17.1.0/27"]
  appgw_subnet_name             = "appgw-subnet"
  appgw_subnet_address_prefixes = ["172.17.1.32/27"]
  nsg_name                      = "nsg-${local.environment}"
  appgw_public_ip_name          = "appgw-public-ip-${local.environment}"
  tags = {
    environment = local.environment
    project     = "nx"
  }
}

# Secrets & Key Vault
module "keyvault" {
  source              = "./modules/keyvault"
  name                = "nx-kv-alpha"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  object_id           = data.azurerm_client_config.current.object_id
  tenant_id           = data.azurerm_client_config.current.tenant_id
  domain_name         = "princetonstrong.online"
  validity_in_months  = 12
}

# DNS Zone
module "dns" {
  source              = "./modules/dns"
  dns_zone_name       = "princetonstrong.online"
  resource_group_name = module.resource_group.resource_group_name
}

# Log Analytics / Monitoring
module "monitoring" {
  source                = "./modules/monitoring"
  name                  = "section31-${local.environment}"
  location              = module.resource_group.resource_group_location
  resource_group_name   = module.resource_group.resource_group_name
  sku                   = "PerGB2018"
  retention_in_days     = 30
  enable_aks_monitoring = true
  tags = {
    environment = local.environment
    project     = "nx"
  }
}

# Application Gateway 
module "application_gateway" {
  source               = "./modules/application_gateway"
  name                 = "appgw-warp-one-${local.environment}"
  location             = module.resource_group.resource_group_location
  resource_group_name  = module.resource_group.resource_group_name
  subnet_id            = module.network.appgw_subnet_id
  public_ip_address_id = module.network.appgw_public_ip_id
  ssl_certificate_name = "nx-alpha"
  key_vault_secret_id  = module.keyvault.secret_id
  depends_on = [
    module.keyvault
  ]

  tags = {
    environment = local.environment
    project     = "nx"
  }
}

# Azure Container Registry (ACR)
module "acr" {
  source              = "./modules/acr"
  name                = "starbase${local.environment}"
  location            = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  tags = {
    environment = local.environment
    project     = "nx"
  }
}

# AKS
module "aks" {
  source              = "./modules/aks"
  tenant_id           = var.tenant_id
  name                = "nx-phoenix-aks"
  acr_id              = module.acr.acr_id
  aks_subnet_id       = module.network.aks_subnet_id
  location            = module.resource_group.resource_group_location
  resource_group_name = module.resource_group.resource_group_name
  dns_prefix          = "nx"
  kubernetes_version  = "1.30"
  admin_group         = var.admin_group

  vm_size                           = "Standard_DS2_v2"
  agents_pool_name                  = "human"
  agents_min_count                  = 1
  agents_max_count                  = 3
  auto_scaling_enabled              = true
  oidc_issuer_enabled               = true
  workload_identity_enabled         = true
  agents_max_pods                   = 100
  appgw_subnet_id                   = module.network.appgw_subnet_id
  rbac_aad                          = true
  role_based_access_control_enabled = true
  log_analytics_workspace_enabled   = true
  log_analytics_workspace_id        = module.monitoring.log_analytics_workspace_id

}

