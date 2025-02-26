// main.tf for the keyvault module
// Define resources specific to keyvault here

resource "azurerm_key_vault" "kv" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id
}

output "id" {
  value = azurerm_key_vault.kv.id
}
