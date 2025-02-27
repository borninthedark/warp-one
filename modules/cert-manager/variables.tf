variable "name" {
  description = "The name of the Cert-Manager Helm release."
  type        = string
}

variable "repo_url" {
  description = "The URL of the Cert-Manager Helm chart repository."
  type        = string
  default     = "https://charts.jetstack.io"
}

variable "version" {
  description = "The version of the Cert-Manager chart."
  type        = string
  default     = "v1.5.4"
}

variable "namespace" {
  description = "The Kubernetes namespace in which to install Cert-Manager."
  type        = string
}