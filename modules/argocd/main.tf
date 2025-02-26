// main.tf for the argocd module
// Define resources specific to argocd here

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = var.repo_url
  chart      = "argo-cd"
  version    = "5.23.1"

  set {
    name  = "server.service.type"
    value = "ClusterIP"
  }

  set {
    name  = "server.ingress.enabled"
    value = "true"
  }

  set {
    name  = "server.ingress.hosts[0]"
    value = "argocd.${var.cluster_name}.starfleet.dev"
  }

  namespace        = var.namespace
  create_namespace = true
}
