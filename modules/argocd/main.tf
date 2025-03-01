resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = var.namespace
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  create_namespace = true
  wait             = true
  timeout          = 600

  set {
    name  = "server.service.type"
    value = "LoadBalancer" # Expose the ArgoCD server using a LoadBalancer service
  }

  set {
    name  = "server.ingress.enabled"
    value = "true" # Enable ingress for ArgoCD
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

  depends_on = [var.kube_config_host]
}