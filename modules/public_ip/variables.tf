variable "name" {
  description = "The name of the public IP resource."
  type        = string
}

variable "location" {
  description = "The Azure region to create the public IP."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which the public IP will be created."
  type        = string
}

variable "allocation_method" {
  description = "The IP allocation method (Static or Dynamic)."
  type        = string
  default     = "Static"
}

variable "sku" {
  description = "The SKU of the public IP (Basic or Standard)."
  type        = string
  default     = "Standard"
}

variable "tags" {
  description = "Tags to apply to the public IP."
  type        = map(string)
  default     = {}
}
