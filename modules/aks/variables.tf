variable "name" {
  description = "The name of the AKS cluster."
  type        = string
}

variable "location" {
  description = "The Azure region where AKS is deployed."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group for AKS."
  type        = string
}

variable "dns_prefix" {
  description = "The DNS prefix for the AKS cluster."
  type        = string
}

variable "kubernetes_version" {
  description = "The Kubernetes version for AKS."
  type        = string
  default     = "1.30.5"
}

variable "appgw_subnet_id" {
  description = "The ID of the Application Gateway subnet."
  type        = string
}
