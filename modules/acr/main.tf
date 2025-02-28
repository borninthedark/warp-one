resource "azurerm_container_registry" "acr" {
  name                     = var.name
  location                 = var.location
  resource_group_name      = var.resource_group_name
  sku                      = var.sku
  admin_enabled            = var.admin_enabled
  georeplications {
    location = var.location
  }

  tags = var.tags
}

