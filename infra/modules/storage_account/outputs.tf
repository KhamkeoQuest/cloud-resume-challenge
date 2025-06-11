output "storage_account_name" {
  value = azurerm_storage_account.storage.name
  description = "Name of the Azure Storage Account"
}

output "storage_account_primary_connection_string" {
  value     = azurerm_storage_account.storage.primary_connection_string
  sensitive = true
  description = "Primary connection string for the Azure Storage Account"
}
