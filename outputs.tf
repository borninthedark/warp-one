# ✅ Outputs
output "resource_group_name" {
  value = module.resource_group.resource_group_name
}

output "network_vnet_id" {
  value = module.network.vnet_id
}

output "aks_subnet_id" {
  value = module.network.aks_subnet_id
}

output "appgw_subnet_id" {
  value = module.network.appgw_subnet_id
}

output "log_analytics_workspace_id" {
  value = module.monitoring.log_analytics_workspace_id
}

output "aks_name" {
  value = module.aks.aks_name
}

output "acr_login_server" {
  value = module.acr.acr_login_server
}

output "public_ip_address" {
  value = module.network.appgw_public_ip_id
}


