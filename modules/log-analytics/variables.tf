variable "name" {
  description = "The name of the Log Analytics Workspace."
  type        = string
}

variable "location" {
  description = "The Azure region where the Log Analytics Workspace will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "The resource group where the Log Analytics Workspace will be created."
  type        = string
}

variable "sku" {
  description = "The SKU of the Log Analytics Workspace. Options: 'Free', 'PerGB2018', 'Standard', 'Premium', 'Unlimited', 'CapacityReservation', 'LACluster'."
  type        = string
  default     = "PerGB2018"
}

variable "retention_in_days" {
  description = "The number of days to retain logs in the Log Analytics Workspace."
  type        = number
  default     = 30
}

variable "enable_aks_monitoring" {
  description = "Whether to enable the Container Insights solution for AKS monitoring."
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to be applied to all resources."
  type        = map(string)
  default     = {}
}
