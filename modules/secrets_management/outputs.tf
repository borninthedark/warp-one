output "keyvault_id" {
  description = "The ID of the Azure Key Vault."
  value       = azurerm_key_vault.keyvault.id
}

output "certificate_secret_id" {
  description = "The Secret ID of the SSL Certificate in Key Vault."
  value       = azurerm_key_vault_certificate.ssl_cert.secret_id
}

