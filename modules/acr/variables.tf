variable "name" {
  description = "The name of the Azure Container Registry."
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9]{5,50}$", var.name))
    error_message = "ACR name must be 5-50 characters long and contain only lowercase letters and numbers."
  }
}
variable "location" {
  description = "The Azure region where the ACR will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "The resource group name where ACR will be created."
  type        = string
}

variable "sku" {
  description = "The SKU of the ACR. Options: 'Basic', 'Standard', 'Premium'."
  type        = string
  default     = "Premium"
}

variable "admin_enabled" {
  description = "Boolean flag to enable the admin account for ACR authentication."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to be applied to the ACR."
  type        = map(string)
  default     = {}
}
