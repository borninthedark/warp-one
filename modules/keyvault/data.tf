# Get the TFC Service Principal Object ID 
data "azuread_service_principal" "tfc" {
  display_name = "tfc-service-principal"
}

# Get Current Azure Env Config 
data "azurerm_client_config" "current" {}
