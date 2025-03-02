# Define locals for environment and location
locals {
  environment = terraform.workspace
  location    = var.location
}

variable "location" {
  description = "The Azure region where resources will be deployed."
  type        = string
  default     = "East US" # Change to your preferred Azure region
}

variable "secret_name" {
  description = "The name of the secret to store in Key Vault."
  type        = string
}

variable "secret_value" {
  description = "The value of the secret to store in Key Vault."
  type        = string
  sensitive   = true
}

