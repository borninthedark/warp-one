output "keyvault_id" {
  description = "The ID of the Azure Key Vault."
  value       = azurerm_key_vault.keyvault.id
}

output "ssl_certificate_name" {
  description = "The name of the SSL certificate stored in Key Vault."
  value       = var.ssl_certificate_name  
}

output "certificate_secret_id" {
  description = "The Secret ID of the SSL Certificate in Key Vault."
  value       = azurerm_key_vault_certificate.ssl_cert.secret_id
}

output "secret_name" {
  description = "The name of the Secret in Key Vault"
  value       = var.secret_name
}

output "secret_value" {
  description = "The Value of the Secret in Key Vault."
  value       = var.secret_value
}
