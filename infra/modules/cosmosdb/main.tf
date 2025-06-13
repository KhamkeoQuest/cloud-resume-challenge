# Terraform module for creating an Azure Cosmos DB account with a SQL database and container.
# This module sets up an Azure Cosmos DB account with serverless capabilities, a SQL database named "resume",
# and a container named "visitorCounter" with a partition key on the "id" field.

resource "azurerm_cosmosdb_account" "cosmos_account" {
  name                = "cosmos-${var.project_name}-${var.environment}-${var.location}"
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }

  capabilities {
    name = "EnableServerless"
  }

  backup {
    type                = "Periodic"
    interval_in_minutes = 240
    retention_in_hours  = 8
  }

  tags = var.tags
}



resource "azurerm_cosmosdb_sql_database" "resume_db" {
  name                = "resume"
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmos_account.name
}

resource "azurerm_cosmosdb_sql_container" "visitor_counter" {
  name                = "visitorCounter"
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmos_account.name
  database_name       = azurerm_cosmosdb_sql_database.resume_db.name
  partition_key_paths = ["/id"]



  unique_key {
  paths = ["/id"]
}

}
