output "aks_name" {
  description = "The name of the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.name
}

output "aks_cluster_id" {
  description = "The ID of the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.id
}

output "kube_config_raw" {
  description = "The raw kubeconfig for connecting to the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}

output "aks_id" {
  description = "The resource ID of the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.id
}