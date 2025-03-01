resource "azurerm_key_vault" "keyvault" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name
  tenant_id           = var.tenant_id

  # Access policies for the Key Vault
  access_policy {
    tenant_id               = var.tenant_id
    object_id               = var.object_id # Typically for a managed identity or service principal
    secret_permissions      = var.secret_permissions
    key_permissions         = var.key_permissions
    certificate_permissions = var.certificate_permissions
  }
  tags = var.tags
}

