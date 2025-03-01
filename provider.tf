provider "azurerm" {
  features {}
}

provider "kubernetes" {
  host                   = module.aks.kube_config[0].host
  cluster_ca_certificate = base64decode(module.aks.kube_config[0].cluster_ca_certificate)
  token                  = module.aks.kube_config[0].token
}

provider "helm" {
  kubernetes {
    host                   = module.aks.kube_config[0].host
    client_certificate     = base64decode(module.aks.kube_config[0].client_certificate)
    client_key             = base64decode(module.aks.kube_config[0].client_key)
    cluster_ca_certificate = base64decode(module.aks.kube_config_ca[0].cluster_ca_certificate)
  }
}


