output "kube_config_host" {
  description = "The Kubernetes API server endpoint."
  value       = azurerm_kubernetes_cluster.aks.kube_config.0.host
}

output "kube_config_ca" {
  description = "The Kubernetes cluster CA certificate."
  value       = azurerm_kubernetes_cluster.aks.kube_config.0.cluster_ca_certificate
  sensitive   = true
}

output "aks_name" {
  description = "The name of the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.name
}

output "kube_config_client_certificate" {
  description = "The client certificate for authenticating to the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate
  sensitive   = true
}

output "kube_config_client_key" {
  description = "The client key for authenticating to the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.kube_config.0.client_key
  sensitive   = true
}

