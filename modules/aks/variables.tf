# Define locals for environment and location
locals {
  environment = terraform.workspace
  location    = var.location
}

variable "name" {
  description = "The name of the AKS cluster."
  type        = string
}

variable "auto_scaling_enabled" {
  description = "Auto Scaling for the AKS Cluster."
  type        = string
  default     = true
}

variable "oidc_issuer_enabled" {
  description = "OIDC for the AKS Cluster."
  type        = string
  default     = true
}

variable "acr_id" {
  description = "Azure Container Registry ID to integrate with AKS."
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

variable "tenant_id" {
  description = "The Azure Tenant ID."
  type        = string
}

variable "kubernetes_version" {
  description = "The Kubernetes version for AKS."
  type        = string
  default     = "1.30"
}

variable "agents_max_count" {
  description = "Maximum number of nodes for autoscaling."
  type        = number
  default     = 2
}

variable "agents_min_count" {
  description = "Minimum number of nodes for autoscaling."
  type        = number
  default     = 1
}

variable "agents_max_pods" {
  description = "Maximum pods per node."
  type        = number
  default     = 100
}

variable "agents_pool_name" {
  description = "The name of the AKS agent pool."
  type        = string
  default     = "testnodepool"
}

variable "agents_type" {
  description = "Type of agent pool (VMSS or AvailabilitySet)."
  type        = string
  default     = "VirtualMachineScaleSets"
}

variable "enable_host_encryption" {
  description = "Enable host encryption on AKS nodes."
  type        = bool
  default     = true
}

variable "create_role_assignments_for_application_gateway" {
  description = "Enable role assignments for AGIC."
  type        = bool
  default     = true
}

variable "local_account_disabled" {
  description = "Disable local admin account."
  type        = bool
  default     = false
}

variable "log_analytics_workspace_enabled" {
  description = "Enable Log Analytics Workspace."
  type        = bool
  default     = false
}

variable "network_plugin" {
  description = "Network plugin for AKS."
  type        = string
  default     = "azure"
}

variable "network_policy" {
  description = "Network policy for AKS."
  type        = string
  default     = "azure"
}

variable "os_disk_size_gb" {
  description = "The OS disk size for AKS nodes."
  type        = number
  default     = 60
}

variable "private_cluster_enabled" {
  description = "Enable private AKS cluster."
  type        = bool
  default     = false
}

variable "rbac_aad" {
  description = "Enable Azure AD RBAC for AKS."
  type        = bool
  default     = true
}

variable "rbac_aad_managed" {
  description = "Use managed Azure AD RBAC."
  type        = bool
  default     = true
}

variable "role_based_access_control_enabled" {
  description = "Enable role-based access control (RBAC)."
  type        = bool
  default     = true
}

variable "sku_tier" {
  description = "The SKU tier for AKS."
  type        = string
  default     = "Standard"
}

variable "aks_subnet_id" {
  description = "The VNet subnet ID for AKS."
  type        = string
}

variable "vm_size" {
  description = "Size of the VMs in the default node pool."
  type        = string
  default     = "Standard_DS2_v2"
}

variable "admin_group" {
  description = "Admin Group for cluster access."
  type        = list(any)
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace for AKS logging."
  type        = string
  default     = null
}

variable "appgw_subnet_id" {
  description = "Subnet ID where the Application Gateway resides."
  type        = string
  default     = null
}
