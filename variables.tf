# Define locals for environment and location
locals {
  environment = "bozeman"
  location    = var.location
}

variable "location" {
  description = "The Azure region where resources will be deployed."
  type        = string
  default     = "West US"
}

variable "ssl_certificate_name" {
  description = "The cert name for the Application Gateway."
  type        = string
  default     = "nx-alpha"
}

variable "client_id" {
  description = "The Client ID (Application ID) of the Service Principal."
  type        = string
  sensitive   = true
}

variable "client_secret" {
  description = "The Client Secret (Password) of the Service Principal."
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "The Azure Tenant ID."
  type        = string
}

variable "subscription_id" {
  description = "The Azure Subscription ID."
  type        = string
}

variable "admin_group" {
  description = "Admin Group for AKS cluster access."
  type        = list(any)
}

variable "password" {
  description = "The password of the SSL certificate stored in Key Vault."
  type        = string
}

variable "trusted_ip" {
  description = "The trusted ip addresses alowed to connect to and access resouces."
  type        = list(string)
}
