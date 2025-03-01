provider "azurerm" {
  features {}
}

provider "kubernetes" {
  host                   = var.kube_config_host
  client_certificate     = base64decode(var.kube_config_client_certificate)
  client_key             = base64decode(var.kube_config_client_key)
  cluster_ca_certificate = base64decode(var.kube_config_ca)
}
