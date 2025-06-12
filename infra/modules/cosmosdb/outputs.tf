output "cosmosdb_account_name" {
  value = azurerm_cosmosdb_account.cosmos_account.name
}

output "cosmosdb_endpoint" {
  value = azurerm_cosmosdb_account.cosmos_account.endpoint
}

output "cosmosdb_primary_key" {
  value = azurerm_cosmosdb_account.cosmos_account.primary_key
  sensitive = true
}
