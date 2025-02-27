output "keyvault_name" {
  description = "The name of the Key Vault."
  value       = azurerm_key_vault.keyvault.name
}

output "keyvault_id" {
  description = "The ID of the Key Vault."
  value       = azurerm_key_vault.keyvault.id
}

output "keyvault_uri" {
  description = "The URI of the Key Vault."
  value       = azurerm_key_vault.keyvault.vault_uri
}

output "keyvault_secrets" {
  description = "List of secrets in the Key Vault."
  value       = azurerm_key_vault.keyvault.secrets
}
