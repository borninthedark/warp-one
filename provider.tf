provider "azurerm" {
  features {}

  # Authentication via Service Principal 
  client_id       = TF_VAR_ARM_CLIENT_ID
  client_secret   = TF_VAR_ARM_CLIENT_SECRET
  tenant_id       = TF_VAR_ARM_TENANT_ID
  subscription_id = TF_VAR_ARM_SUBSCRIPTION_ID
}


provider "kubernetes" {
  host                   = module.aks.kube_config_host
  client_certificate     = base64decode(module.aks.kube_config_client_certificate)
  client_key             = base64decode(module.aks.kube_config_client_key)
  cluster_ca_certificate = base64decode(module.aks.kube_config_ca)
}
