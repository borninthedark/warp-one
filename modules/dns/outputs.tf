// outputs.tf for the dns module
// Declare outputs that other modules or environments can reference

output "dns_zone_name" {
  description = "The name of the created DNS zone"
  value       = azurerm_dns_zone.dns_zone.name
}

output "dns_zone_id" {
  description = "The ID of the created DNS zone"
  value       = azurerm_dns_zone.dns_zone.id
}

output "cname_record" {
  description = "The created CNAME record (if applicable)"
  value       = var.create_cname ? azurerm_dns_cname_record.cname[0].fqdn : ""
}

output "a_record" {
  description = "The created A record (if applicable)"
  value       = var.create_a_record ? azurerm_dns_a_record.a_record[0].fqdn : ""
}
