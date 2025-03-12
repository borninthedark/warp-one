variable "name" {
  description = "The name of the Key Vault."
  type        = string
  default     = "nx-kv-alpha"
}

variable "location" {
  description = "The Azure region where the Key Vault is deployed."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "tenant_id" {
  description = "The Azure Tenant ID."
  type        = string
}

variable "object_id" {
  description = "The Object ID of the Service Principal to grant Key Vault access."
  type        = string
}

variable "password" {
  description = "The password of the SSL certificate stored in Key Vault."
  type        = string
}

variable "domain_name" {
  description = "The domain name for the SSL certificate."
  type        = string
}

variable "validity_in_months" {
  description = "The validity period of the SSL certificate in months."
  type        = number
  default     = 12
}

variable "ssl_certificate_name" {
  description = "The name of the SSL certificate used by Application Gateway & stored in AzKV."
  type        = string
}
