variable "name" {
  description = "The name of the Key Vault."
  type        = string
}

variable "location" {
  description = "The location (Azure region) to deploy the Key Vault."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the Key Vault will be deployed."
  type        = string
}

variable "sku_name" {
  description = "The SKU of the Key Vault. Options: 'standard', 'premium'."
  type        = string
  default     = "standard"
}

variable "tenant_id" {
  description = "The tenant ID in which the Key Vault will be created."
  type        = string
}

variable "object_id" {
  description = "The object ID of the principal (user, service principal, managed identity) to grant access to the Key Vault."
  type        = string
}

variable "secret_permissions" {
  default = ["Get", "List", "Set", "Delete"]
}

variable "key_permissions" {
  default = ["Get", "List", "Create", "Import"]
}

variable "certificate_permissions" {
  default = ["Get", "List"]
}

variable "tags" {
  description = "Tags to be applied to the Key Vault."
  type        = map(string)
  default     = {}
}
