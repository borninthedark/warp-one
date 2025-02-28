output "aks_name" {
  description = "The name of the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.name
}

output "aks_cluster_id" {
  description = "The ID of the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.id
}

output "aks_kube_config" {
  description = "The kubeconfig for connecting to the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw  # ✅ Fix: Correct attribute
  sensitive   = true
}

output "aks_id" {
  description = "The resource ID of the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.id
}