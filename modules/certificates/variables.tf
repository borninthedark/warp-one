variable "ssl_certificate_name" {
  description = "The name of the SSL certificate."
  type        = string
}

variable "key_vault_id" {
  description = "The ID of the Azure Key Vault where the SSL certificate is stored."
  type        = string
}

variable "aks_managed_identity_id" {
  description = "The Managed Identity ID of the AKS cluster for accessing Key Vault."
  type        = string
}

variable "appgw_managed_identity_id" {
  description = "The Managed Identity ID of the Application Gateway for accessing Key Vault."
  type        = string
}

variable "domain_name" {
  description = "The domain name for the SSL certificate."
  type        = string
}

variable "validity_in_months" {
  description = "The validity period of the SSL certificate in months."
  type        = number
  default     = 12
}
