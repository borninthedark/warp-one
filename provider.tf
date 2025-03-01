provider "azurerm" {
  features {}
}

provider "kubernetes" {
  host                   = module.aks.kube_config_host[0].host
  cluster_ca_certificate = base64decode(module.aks.kube_config_host[0].cluster_ca_certificate)
  token                  = module.aks.kube_config_host[0].token
}

provider "helm" {
  kubernetes {
    host                   = module.aks.kube_config_host[0].host
    client_certificate     = base64decode(module.aks.kube_config_host_client_certificate)
    client_key             = base64decode(module.aks.kube_config_host_client_key)
    cluster_ca_certificate = base64decode(module.aks.kube_config_host_ca)
  }
}


