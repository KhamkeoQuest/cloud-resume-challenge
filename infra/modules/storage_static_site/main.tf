resource "azurerm_storage_account" "static_site" {
  name                     = "st${var.project_name}${var.environment}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"


  static_website {
    index_document     = "index.html"
    error_404_document = "404.html"
  }

  tags = var.tags
}
resource "azurerm_storage_container" "web" {
  name                  = "$web"
  storage_account_name  = azurerm_storage_account.static_site.name
  container_access_type = "blob"
}

resource "azurerm_storage_blob" "index" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.static_site.name
  storage_container_name = azurerm_storage_container.web.name
  type                   = "Block"
  source                 = var.index_path
}

resource "azurerm_storage_blob" "error" {
  name                   = "404.html"
  storage_account_name   = azurerm_storage_account.static_site.name
  storage_container_name = azurerm_storage_container.web.name
  type                   = "Block"
  source                 = var.error_path
}

resource "azurerm_storage_blob" "resume" {
  name                   = "resume.pdf"
  storage_account_name   = azurerm_storage_account.static_site.name
  storage_container_name = azurerm_storage_container.web.name
  type                   = "Block"
  source                 = var.resume_path
}

