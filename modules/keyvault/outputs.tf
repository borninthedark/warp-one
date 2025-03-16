# Output the Service Principal App ID
output "service_principal_app_id" {
  value = data.azuread_service_principal.sp.object_id
}

output "key_vault_secret_id" {
  description = "The ID of the Azure Resource Group."
  value       = azurerm_key_vault_certificate.nx.id
}
