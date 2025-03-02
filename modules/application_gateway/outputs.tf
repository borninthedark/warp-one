output "app_gateway_public_ip" {
  description = "The public IP of the Application Gateway."
  value       = azurerm_application_gateway.appgw.frontend_ip_configuration[0].public_ip_address_id
}

output "appgw_id" {
  description = "The ID of the Application Gateway."
  value       = azurerm_application_gateway.appgw.id
}

output "appgw_frontend_ip" {
  description = "The frontend IP configuration of the Application Gateway."
  value       = azurerm_application_gateway.appgw.frontend_ip_configuration[0].id
}

output "appgw_backend_pool_id" {
  description = "The backend pool ID for the Application Gateway."
  value       = azurerm_application_gateway.appgw.backend_address_pool[0].id
}
