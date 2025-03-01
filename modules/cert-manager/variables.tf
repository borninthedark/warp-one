variable "name" {
  description = "The name of the Cert-Manager Helm release."
  type        = string
}

variable "repo_url" {
  description = "The URL of the Cert-Manager Helm chart repository."
  type        = string
  default     = "https://charts.jetstack.io"
}

variable "cm_version" {
  description = "The version of the Cert-Manager chart."
  type        = string
  default     = "v1.5.4"
}

variable "namespace" {
  description = "The Kubernetes namespace in which to install Cert-Manager."
  type        = string
}

variable "kube_config_host" {
  description = "The Kubernetes API server endpoint."
  type        = string
}

variable "kube_config_client_certificate" {
  description = "The client certificate for authenticating to the AKS cluster."
  type        = string
}

variable "kube_config_client_key" {
  description = "The client key for authenticating to the AKS cluster."
  type        = string
}

variable "kube_config_ca" {
  description = "The Kubernetes cluster CA certificate."
  type        = string
}
