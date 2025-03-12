resource "azurerm_application_gateway" "appgw" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    name = "Standard_v2"
    tier = "Standard_v2"
  }

  autoscale_configuration {
    min_capacity = 2
    max_capacity = 10
  }

  gateway_ip_configuration {
    name      = "appgw-ip-config"
    subnet_id = var.subnet_id
  }

  frontend_ip_configuration {
    name                 = "frontend-ip"
    public_ip_address_id = var.public_ip_address_id
  }

  frontend_port {
    name = "https-port"
    port = 443
  }

  backend_address_pool {
    name = "backend-pool"
  }

  backend_http_settings {
    name                  = "backend-http-settings"
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 30
  }

  ssl_certificate {
    name                = var.ssl_certificate_name
    key_vault_secret_id = var.key_vault_secret_id
    password            = var.password
  }

  http_listener {
    name                           = "https-listener"
    frontend_ip_configuration_name = "frontend-ip"
    frontend_port_name             = "https-port"
    protocol                       = "Https"
    ssl_certificate_name           = var.ssl_certificate_name
  }

  request_routing_rule {
    name                       = "https-routing-rule"
    rule_type                  = "Basic"
    http_listener_name         = "https-listener"
    backend_address_pool_name  = "backend-pool"
    backend_http_settings_name = "backend-http-settings"
    priority                   = 1
  }

  tags = var.tags

}
