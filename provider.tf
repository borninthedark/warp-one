provider "azurerm" {
  features {}
}

provider "kubernetes" {
  host                   = module.aks.kube_config[0].host
  cluster_ca_certificate = base64decode(module.aks.kube_config[0].cluster_ca_certificate)
  token                  = module.aks.kube_config[0].token
}




