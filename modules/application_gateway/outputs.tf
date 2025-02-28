output "app_gateway_id" {
  description = "The ID of the Application Gateway."
  value       = azurerm_application_gateway.appgw.id
}

output "app_gateway_public_ip" {
  description = "The public IP of the Application Gateway."
  value       = azurerm_application_gateway.appgw.frontend_ip_configuration[0].public_ip_address_id
}
