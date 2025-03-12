# Get Current Azure Env Config 
data "azurerm_client_config" "current" {}

data "azurerm_key_vault_certificate" "nx" {
  name         = "nx"
  key_vault_id = azurerm_key_vault.keyvault.id
}

# Get the Azure AD Service Principal by its display name
data "azuread_service_principal" "sp" {
  display_name = "tfc-service-principal"
}

