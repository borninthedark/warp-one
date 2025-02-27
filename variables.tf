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

variable "dns_zone_name" {
  description = "The name of the DNS zone."
  type        = string
  default     = "warp-one.com" # Replace with your desired DNS zone name
}

