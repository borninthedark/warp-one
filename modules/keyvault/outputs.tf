# Output the Service Principal App ID
output "service_principal_app_id" {
  value = data.azuread_service_principal.sp.object_id
}
