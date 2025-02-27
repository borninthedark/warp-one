### AKS ###
output "aks_name" {
  value = module.aks.aks_name
}

output "aks_cluster_id" {
  value = module.aks.aks_cluster_id
}

output "aks_kube_config" {
  value = module.aks.aks_kube_config
}

### KEY VAULT ### 
output "keyvault_name" {
  value = module.keyvault.keyvault_name
}

output "keyvault_uri" {
  value = module.keyvault.keyvault_uri
}

### ACR ### 
output "acr_name" {
  value = module.acr.acr_name
}

output "acr_login_server" {
  value = module.acr.acr_login_server
}

output "acr_id" {
  value = module.acr.acr_id
}

### RESOURCE GROUP ### 
output "resource_group_name" {
  value = module.resource_group.resource_group_name
}

output "resource_group_location" {
  value = module.resource_group.resource_group_location
}

output "resource_group_id" {
  value = module.resource_group.resource_group_id
}

### PUBLIC IP ### 
output "public_ip_id" {
  value = module.public_ip.public_ip_id
}

output "public_ip_address" {
  value = module.public_ip.public_ip_address
}

### APPGW ###
output "application_gateway_id" {
  value = module.application_gateway.app_gateway_id
}
