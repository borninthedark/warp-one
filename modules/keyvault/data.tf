# Get Current Azure Env Config 
data "azurerm_client_config" "current" {}

data "azurerm_key_vault_certificate" "nx" {
  name         = "nx"
  key_vault_id = azurerm_key_vault.keyvault.id
}
