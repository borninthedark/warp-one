# Define locals for environment and location
locals {
  environment = "worf"
  location    = var.location
}

variable "location" {
  description = "The Azure region where resources will be deployed."
  type        = string
  default     = "West US"
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
