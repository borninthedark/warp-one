// providers.tf
// Common provider configurations (e.g., azurerm, kubernetes, helm)

provider "azurerm" {
  features {}
}

provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.aks.kube_config.0.host
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate)
  token                  = azurerm_kubernetes_cluster.aks.kube_config.0.token
}

provider "helm" {
  kubernetes {
    host                   = azurerm_kubernetes_cluster.aks.kube_config.0.host
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate)
    token                  = azurerm_kubernetes_cluster.aks.kube_config.0.token
  }
}
