variable "resource_group_name" {
  description = "The name of the resource group where networking resources will be created."
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be deployed."
  type        = string
}

variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "vnet_address_space" {
  description = "The address space for the virtual network."
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
  description = "The name of the Network Security Group (NSG)."
  type        = string
}

variable "appgw_public_ip_name" {
  description = "The name of the public IP for the Application Gateway."
  type        = string
}

variable "tags" {
  description = "A map of tags to be applied to all resources."
  type        = map(string)
  default     = {}
}
