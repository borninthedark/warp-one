output "aks_name" {
  value = module.aks.aks_name
}

output "kubeconfig" {
  value = module.aks.aks_kube_config
}

output "keyvault_name" {
  value = module.keyvault.keyvault_name
}

output "keyvault_uri" {
  value = module.keyvault.keyvault_uri
}

output "acr_name" {
  value = module.acr.acr_name
}

output "acr_login_server" {
  value = module.acr.acr_login_server
}

output "acr_id" {
  value = module.acr.acr_id
}