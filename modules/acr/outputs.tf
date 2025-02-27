output "acr_name" {
  description = "The name of the Azure Container Registry."
  value       = azurerm_container_registry.acr.name
}

output "acr_login_server" {
  description = "The login server URL of the Azure Container Registry."
  value       = azurerm_container_registry.acr.login_server
}

output "acr_id" {
  description = "The ID of the Azure Container Registry."
  value       = azurerm_container_registry.acr.id
}

output "acr_registry_uri" {
  description = "The registry URI of the Azure Container Registry."
  value       = azurerm_container_registry.acr.login_server
}