provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-resume-prod-wus3"
  location = "West US 3"
  tags = {
  environment = "prod"
  project     = "cloud-resume"
}

}

resource "azurerm_resource_group" "rg" {
  name     = "rg-resume-prod-scus"
  location = "South Central US"
  tags = {
  environment = "prod"
  project     = "cloud-resume"
}

}

resource "azurerm_storage_account" "storage" {
  name                     = "crstorage${random_id.unique.hex}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "RAGRS"
}

resource "azurerm_storage_table" "counter" {
  name                 = "VisitorCounter"
  storage_account_name = azurerm_storage_account.storage.name
  resource_group_name  = azurerm_resource_group.rg.name
}
resource "azurerm_storage_table" "resume" {
  name                 = "Resume"
  storage_account_name = azurerm_storage_account.storage.name
  resource_group_name  = azurerm_resource_group.rg.name
} 