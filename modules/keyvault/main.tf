resource "azurerm_key_vault" "keyvault" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "standard"
  tenant_id           = var.tenant_id
}

resource "azurerm_key_vault_access_policy" "module" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = var.tenant_id
  object_id    = var.object_id

  certificate_permissions = [
    "Create",
    "Delete",
    "DeleteIssuers",
    "Get",
    "GetIssuers",
    "Import",
    "List",
    "ListIssuers",
    "ManageContacts",
    "ManageIssuers",
    "SetIssuers",
    "Update",
  ]

  key_permissions = [
    "Backup",
    "Create",
    "Decrypt",
    "Delete",
    "Encrypt",
    "Get",
    "Import",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Sign",
    "UnwrapKey",
    "Update",
    "Verify",
    "WrapKey",
  ]

  secret_permissions = [
    "Backup",
    "Delete",
    "Get",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Set",
  ]
}

# Create a User-Assigned Managed Identity
resource "azurerm_user_assigned_identity" "mi_keyvault_access" {
  name                = "mi-keyvault-access"
  location            = var.location
  resource_group_name = var.resource_group_name
}

# Assign "Key Vault Certificates Reader" Role to the Managed Identity
resource "azurerm_role_assignment" "kv_cert_reader" {
  scope                = azurerm_key_vault.keyvault.id
  role_definition_name = "Key Vault Reader"
  principal_id         = azurerm_user_assigned_identity.mi_keyvault_access.principal_id
}

# Assign the Managed Identity to the Service Principal
resource "azurerm_federated_identity_credential" "sp_identity" {
  name                = "sp-keyvault-access"
  resource_group_name = var.resource_group_name
  issuer              = "https://sts.windows.net/${var.tenant_id}/"
  subject             = "appid=df7d79fc-2099-4df5-9822-bfc960a6fca4"
  audience            = ["api://AzureADTokenExchange"]
  parent_id           = azurerm_user_assigned_identity.mi_keyvault_access.id
}

resource "azurerm_key_vault_access_policy" "tfc" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = var.tenant_id
  object_id    = data.azuread_service_principal.sp.client_id

  certificate_permissions = [
    "Create",
    "Delete",
    "DeleteIssuers",
    "Get",
    "GetIssuers",
    "Import",
    "List",
    "ListIssuers",
    "ManageContacts",
    "ManageIssuers",
    "SetIssuers",
    "Update",
  ]

  key_permissions = [
    "Backup",
    "Create",
    "Decrypt",
    "Delete",
    "Encrypt",
    "Get",
    "Import",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Sign",
    "UnwrapKey",
    "Update",
    "Verify",
    "WrapKey",
  ]

  secret_permissions = [
    "Backup",
    "Delete",
    "Get",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Set",
  ]
}

resource "azurerm_key_vault_certificate" "nx" {
  name         = "nx-alpha"
  key_vault_id = azurerm_key_vault.keyvault.id

  certificate {
    contents = filebase64("pso.pfx")
    password = var.password
  }
}