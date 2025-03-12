# Get Current Azure Env Config 
data "azurerm_client_config" "current" {}

# Get the Azure AD Service Principal by its display name
data "azuread_service_principal" "sp" {
  display_name = "tfc-service-principal"
}

