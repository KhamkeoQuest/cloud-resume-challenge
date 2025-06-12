# Not used as I'm going twith cosmosdb serverless for the Cloud Resume Challenge.

# This module creates an Azure Storage Account with a Table for the Cloud Resume Challenge.
# Ragrs (Read Access Geo-Redundant Storage) is used for high availability.
resource "azurerm_storage_account" "storage" {
  name                     = "st${var.project_name}${var.environment}table"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "RAGRS"  # Read Access Geo-Redundant Storage

  min_tls_version = "TLS1_2"

  tags = var.tags

}

# This module creates a unique suffix for the storage account name to ensure it is globally unique.
resource "random_integer" "unique_suffix" {
  min = 10000
  max = 99999
}

# This module creates a table in the Azure Storage Account to store visitor counts.
resource "azurerm_storage_table" "visitor_count" {
  name                 = "visitorcounter"
  storage_account_name = azurerm_storage_account.storage.name
}
