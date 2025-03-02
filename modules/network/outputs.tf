output "vnet_id" {
  description = "The ID of the Virtual Network."
  value       = azurerm_virtual_network.vnet.id
}

output "aks_subnet_id" {
  description = "The ID of the AKS subnet."
  value       = azurerm_subnet.aks_subnet.id
}

output "appgw_subnet_id" {
  description = "The ID of the Application Gateway subnet."
  value       = azurerm_subnet.appgw_subnet.id
}

output "appgw_public_ip_id" {
  description = "The ID of the Public IP for Application Gateway."
  value       = azurerm_public_ip.appgw_public_ip.id
}

