resource "helm_release" "cert_manager" {
  name       = var.name
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "v1.5.4"

  namespace        = var.namespace
  create_namespace = true
  wait             = true
  timeout          = 600

  set {
    name  = "installCRDs"
    value = "true"
  }
}