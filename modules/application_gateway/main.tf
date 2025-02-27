resource "azurerm_application_gateway" "appgw" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
  }

  frontend_ip_configuration {
    name                 = "frontend-ip"
    public_ip_address_id = var.public_ip_address_id
  }

  gateway_ip_configuration {
    name      = "appgw-ip-config"
    subnet_id = module.network.appgw_subnet_id
  }

  tags = var.tags
}


