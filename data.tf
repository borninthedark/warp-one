# Get Current Azure Env Config 
data "azurerm_client_config" "current" {}

# Get the Azure AD Service Principal by its display name
data "azuread_service_principal" "sp" {
  display_name = "tfc-service-principal"  

# Output the Service Principal App ID
output "service_principal_app_id" {
  value = data.azuread_service_principal.sp.application_id
}
