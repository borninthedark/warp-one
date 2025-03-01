variable "name" {
  description = "The name of the ArgoCD Helm release."
  type        = string
}

variable "repo_url" {
  description = "The URL of the ArgoCD Helm chart repository."
  type        = string
  default     = "https://argoproj.github.io/argo-helm"
}

variable "argo_version" {
  description = "The version of the ArgoCD chart."
  type        = string
  default     = "5.23.1"
}

variable "namespace" {
  description = "The Kubernetes namespace in which to install ArgoCD."
  type        = string
}

variable "argocd_url" {
  description = "The hostname to access ArgoCD (e.g., argocd.princetonstrong.online)."
  type        = string
}

variable "argocd_tls_secret" {
  description = "The name of the secret containing the TLS certificate for ArgoCD ingress."
  type        = string
}

variable "repo_image_tag" {
  description = "The image tag to use for the ArgoCD repo server."
  type        = string
  default     = "v2.3.3"
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
