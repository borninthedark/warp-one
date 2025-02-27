resource "helm_release" "cert_manager" {
  name       = var.name
  repository = var.repo_url
  chart      = "cert-manager"
  version    = var.version

  namespace        = var.namespace
  create_namespace = true
  wait             = true
  timeout          = 600

  set {
    name  = "installCRDs"
    value = "true"  # Install Cert-Manager's Custom Resource Definitions
  }
}