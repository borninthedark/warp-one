terraform {
  required_version = ">= 1.2.0"
}

locals {
  environment = terraform.workspace
  location    = var.location
}

# Resource Group
module "resource_group" {
  source   = "../../modules/resource_group"
  name     = "rg-warp-one-${local.environment}"
  location = local.location
}

# Key Vault
module "keyvault" {
  source         = "../../modules/keyvault"
  name           = "kv-warp-one-${local.environment}"
  resource_group = module.resource_group.name
  location       = module.resource_group.location
}

# DNS Zone
module "dns" {
  source         = "../../modules/dns"
  dns_zone_name  = var.dns_zone_name
  resource_group = module.resource_group.name
}

# Azure Container Registry
module "acr" {
  source         = "../../modules/acr"
  name           = "acr-warp-one-${local.environment}"
  resource_group = module.resource_group.name
  location       = module.resource_group.location
}

# AKS Cluster
module "aks" {
  source         = "../../modules/aks"
  name           = "aks-warp-one-${local.environment}"
  resource_group = module.resource_group.name
  location       = module.resource_group.location
  dns_prefix     = "akswarpone"
}

# Argo CD Deployment
module "argocd" {
  source       = "../../modules/argocd"
  repo_url     = "https://argoproj.github.io/argo-helm"
  namespace    = "argocd"
  cluster_name = module.aks.name
}