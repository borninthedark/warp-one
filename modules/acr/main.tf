// main.tf for the acr module
// Define resources specific to acr here

resource "azurerm_container_registry" "acr" {
  name                = var.name
  resource_group_name = var.resource_group
  location            = var.location
  sku                 = "Premium"
  admin_enabled       = false
}

output "id" {
  value = azurerm_container_registry.acr.id
}
