output "static_site_url" {
  description = "The primary endpoint of the static website"
  value       = azurerm_storage_account.static_site.primary_web_endpoint
}

output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.static_site.name
}
