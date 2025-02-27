variable "name" {
  description = "The name of the Application Gateway."
  type        = string
}

variable "location" {
  description = "The location of the Application Gateway."
  type        = string
}

variable "resource_group_name" {
  description = "The resource group where the Application Gateway will be created."
  type        = string
}

variable "public_ip_address_id" {
  description = "The ID of the public IP address for the Application Gateway."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the Application Gateway will be deployed."
  type        = string
}

variable "tags" {
  description = "Tags to apply to the Application Gateway."
  type        = map(string)
  default     = {}
}
