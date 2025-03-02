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

variable "node_count" {
  description = "Number of nodes in the default node pool."
  type        = number
  default     = 2
}

variable "vm_size" {
  description = "Size of the VMs in the node pool."
  type        = string
  default     = "Standard_DS2_v2"
}

variable "rbac_enabled" {
  description = "Enable Role-Based Access Control (RBAC) in AKS."
  type        = bool
  default     = true
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics Workspace ID for AKS monitoring."
  type        = string
}

variable "acr_id" {
  description = "Azure Container Registry ID to integrate with AKS."
  type        = string
}

variable "appgw_subnet_id" {
  description = "The ID of the Application Gateway subnet."
  type        = string
}
