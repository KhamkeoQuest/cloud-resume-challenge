output "static_storage_url" {
  value = azurerm_storage_account.static_storage.primary_web_endpoint
}


output "storage_account_name" {
  description = "The name of the storage account"
  value = azurerm_storage_account.static_storage.name
}

output "web_container_name" {
  value = "$web"
}
