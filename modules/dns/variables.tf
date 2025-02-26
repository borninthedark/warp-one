// variables.tf for the dns module
// Define input variables required by this module

# Required Variables
variable "dns_zone_name" {
  description = "The name of the DNS zone"
  type        = string
}

variable "resource_group" {
  description = "The name of the Azure resource group where the DNS zone will be created"
  type        = string
}

# Optional CNAME Record
variable "create_cname" {
  description = "Boolean to determine if a CNAME record should be created"
  type        = bool
  default     = false
}

variable "cname_record" {
  description = "The subdomain for the CNAME record"
  type        = string
  default     = "argocd"
}

variable "cname_target" {
  description = "The target domain for the CNAME record (e.g., Application Gateway FQDN)"
  type        = string
  default     = "your-app-gateway.azure.com"
}

# Optional A Record
variable "create_a_record" {
  description = "Boolean to determine if an A record should be created"
  type        = bool
  default     = false
}

variable "a_record_name" {
  description = "The subdomain for the A record"
  type        = string
  default     = "api"
}

variable "a_record_ips" {
  description = "The list of IP addresses for the A record"
  type        = list(string)
  default     = []
}

variable "ttl" {
  description = "Time to live for DNS records"
  type        = number
  default     = 300
}
