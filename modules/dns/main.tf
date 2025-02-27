resource "azurerm_dns_zone" "dns_zone" {
  name                = var.dns_zone_name
  resource_group_name = var.resource_group_name
  location            = "global"
}

resource "azurerm_dns_a_record" "dns_a_record" {
  count               = length(var.a_records)
  name                = var.a_records[count.index].name
  zone_name           = azurerm_dns_zone.dns_zone.name
  resource_group_name = var.resource_group_name
  ttl                 = var.ttl
  records             = [var.a_records[count.index].ip_address]
}

resource "azurerm_dns_cname_record" "dns_cname_record" {
  count               = length(var.cname_records)
  name                = var.cname_records[count.index].name
  zone_name           = azurerm_dns_zone.dns_zone.name
  resource_group_name = var.resource_group_name
  ttl                 = var.ttl
  record              = var.cname_records[count.index].target
}


