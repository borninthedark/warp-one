variable "name" {
  description = "The name of the AKS cluster."
  type        = string
}

variable "location" {
  description = "The location (Azure region) to deploy the AKS cluster."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group to deploy the AKS cluster."
  type        = string
}

variable "dns_prefix" {
  description = "The DNS prefix for the AKS cluster."
  type        = string
}

variable "kubernetes_version" {
  description = "The version of Kubernetes to use in the AKS cluster."
  type        = string
  default     = "1.21.5"  # Change as needed
}

variable "node_count" {
  description = "The number of nodes in the AKS node pool."
  type        = number
  default     = 3
}

variable "vm_size" {
  description = "The VM size for AKS nodes."
  type        = string
  default     = "Standard_DS2_v2"
}

variable "rbac_enabled" {
  description = "Whether to enable RBAC on the AKS cluster."
  type        = bool
  default     = true
}

variable "azure_policy_enabled" {
  description = "Whether to enable Azure Policy add-on."
  type        = bool
  default     = true
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace to use for monitoring."
  type        = string
}

variable "tags" {
  description = "Tags to be applied to the AKS cluster."
  type        = map(string)
  default     = {}
}

variable "acr_id" {
  description = "The ID of the Azure Container Registry to allow AKS to pull images from."
  type        = string
}

variable "app_gateway_id" {
  description = "The ID of the Application Gateway to be used with AGIC."
  type        = string
}