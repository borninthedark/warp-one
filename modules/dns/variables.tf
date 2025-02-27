variable "dns_zone_name" {
  description = "The name of the DNS zone (e.g., princetonstrong.online)."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the DNS zone will be created."
  type        = string
}

variable "a_records" {
  description = "A list of A record configurations."
  type = list(object({
    name       = string
    ip_address = string
  }))
  default = []
}

variable "cname_records" {
  description = "A list of CNAME record configurations."
  type = list(object({
    name   = string
    target = string
  }))
  default = []
}

variable "ttl" {
  description = "The time-to-live (TTL) for the DNS records in seconds."
  type        = number
  default     = 300
}
