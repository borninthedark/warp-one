output "aks_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "aks_kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0.raw_kube_config
}

output "aks_kube_config_raw" {
  value = azurerm_kubernetes_cluster.aks.kube_config.0.raw_kube_config
}

output "aks_id" {
  value = azurerm_kubernetes_cluster.aks.id
}