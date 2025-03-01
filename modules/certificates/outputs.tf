output "certificate_secret_id" {
  description = "The Secret ID of the SSL Certificate in Key Vault."
  value       = azurerm_key_vault_certificate.ssl_cert.secret_id
}

output "ssl_certificate_name" {
  description = "The name of the SSL certificate stored in Key Vault."
  value       = azurerm_key_vault_certificate.ssl_cert.name # ✅ Correct output
}
