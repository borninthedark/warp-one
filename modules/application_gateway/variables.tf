variable "name" {
  description = "The name of the Application Gateway."
  type        = string
}

variable "location" {
  description = "The Azure region where the Application Gateway will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "The resource group where the Application Gateway will be created."
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID where the Application Gateway is deployed."
  type        = string
}

variable "public_ip_address_id" {
  description = "The public IP ID assigned to the Application Gateway."
  type        = string
}

variable "ssl_certificate_name" {
  description = "The name of the SSL certificate to use for HTTPS."
  type        = string
  default     = "appgw-ssl-cert"
}

variable "tags" {
  description = "A map of tags to apply to the Application Gateway."
  type        = map(string)
  default     = {}
}

variable "ssl_certificate_secret_id" {
  description = "The Secret ID of the SSL certificate in Key Vault."
  type        = string
}
