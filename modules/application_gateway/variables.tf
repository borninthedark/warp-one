variable "name" {
  description = "The name of the Application Gateway."
  type        = string
}

variable "location" {
  description = "The Azure region for the Application Gateway."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where Application Gateway is deployed."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where Application Gateway is deployed."
  type        = string
}

variable "public_ip_address_id" {
  description = "The ID of the Public IP address for the Application Gateway."
  type        = string
}

variable "ssl_certificate_name" {
  description = "The cert name for the Application Gateway."
  type        = string
}

variable "tags" {
  description = "Tags to be applied to the Application Gateway."
  type        = map(string)
  default     = {}
}

variable "key_vault_secret_id" {
  description = "The key_vault_secret_id of the SSL certificate stored in Key Vault."
  type        = string
}
