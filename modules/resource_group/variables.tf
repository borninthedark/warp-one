variable "name" {
  description = "The name of the Azure Resource Group."
  type        = string
}

variable "location" {
  description = "The Azure region where the resource group will be created."
  type        = string
}

variable "tags" {
  description = "Tags to be applied to the resource group."
  type        = map(string)
  default     = {}
}
