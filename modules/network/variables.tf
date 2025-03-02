variable "location" {
  description = "The Azure region for network resources."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "vnet_name" {
  description = "The name of the Virtual Network."
  type        = string
}

variable "vnet_address_space" {
  description = "The address space for the Virtual Network."
  type        = list(string)
}

variable "aks_subnet_name" {
  description = "The name of the AKS subnet."
  type        = string
}

variable "aks_subnet_address_prefixes" {
  description = "The address prefixes for the AKS subnet."
  type        = list(string)
}

variable "appgw_subnet_name" {
  description = "The name of the Application Gateway subnet."
  type        = string
}

variable "appgw_subnet_address_prefixes" {
  description = "The address prefixes for the Application Gateway subnet."
  type        = list(string)
}

variable "nsg_name" {
  description = "The name of the Network Security Group."
  type        = string
}

variable "appgw_public_ip_name" {
  description = "The name of the Public IP for Application Gateway."
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources."
  type        = map(string)
  default     = {}
}
