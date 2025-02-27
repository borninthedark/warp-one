resource "helm_release" "argocd" {
  name       = var.name
  repository = var.repo_url
  chart      = "argo-cd"
  version    = var.version

  namespace          = var.namespace
  create_namespace   = true
  wait               = true
  timeout            = 600

  set {
    name  = "server.service.type"
    value = "LoadBalancer"  # Expose the ArgoCD server using a LoadBalancer service
  }

  set {
    name  = "server.ingress.enabled"
    value = "true"  # Enable ingress for ArgoCD
  }

  set {
    name  = "server.ingress.hosts[0]"
    value = var.argocd_url
  }

  set {
    name  = "server.ingress.tls[0].hosts[0]"
    value = var.argocd_url
  }

  set {
    name  = "server.ingress.tls[0].secretName"
    value = var.argocd_tls_secret
  }

  set {
    name  = "repoServer.image.tag"
    value = var.repo_image_tag
  }
}

