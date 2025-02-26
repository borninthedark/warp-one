// main.tf for the dns module
// Define resources specific to dns here

# Create an Azure DNS Zone
resource "azurerm_dns_zone" "dns_zone" {
  name                = var.dns_zone_name
  resource_group_name = var.resource_group
}

# Create an optional CNAME record (e.g., for ArgoCD)
resource "azurerm_dns_cname_record" "cname" {
  count               = var.create_cname ? 1 : 0
  name                = var.cname_record
  zone_name           = azurerm_dns_zone.dns_zone.name
  resource_group_name = var.resource_group
  ttl                 = var.ttl
  record              = var.cname_target
}

# Create an optional A record (e.g., pointing to a load balancer)
resource "azurerm_dns_a_record" "a_record" {
  count               = var.create_a_record ? 1 : 0
  name                = var.a_record_name
  zone_name           = azurerm_dns_zone.dns_zone.name
  resource_group_name = var.resource_group
  ttl                 = var.ttl
  records             = var.a_record_ips
}
