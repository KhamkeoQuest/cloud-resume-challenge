resource "azurerm_storage_account" "static_storage" {
  name                     = "sa${var.project_name}${var.environment}static"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags

  }
  
  resource "azurerm_storage_account_static_website" "static_website" {
    storage_account_id = azurerm_storage_account.static_storage.id
    index_document     = "index.html"
    error_404_document = "404.html"
}



resource "azurerm_storage_blob" "index" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.static_storage.name
  storage_container_name = "$web"
  type                   = "Block"
  source                 = var.index_path
  content_type           = "text/html"
  depends_on             = [azurerm_storage_account_static_website.static_website]
}

resource "azurerm_storage_blob" "error" {
  name                   = "404.html"
  storage_account_name   = azurerm_storage_account.static_storage.name
  storage_container_name = "$web"
  type                   = "Block"
  source                 = var.error_path
  depends_on             = [azurerm_storage_account_static_website.static_website]
}

resource "azurerm_storage_blob" "resume" {
  name                   = "khamkeo_khongsaly_resume.html"
  storage_account_name   = azurerm_storage_account.static_storage.name
  storage_container_name = "$web"
  type                   = "Block"
  source                 = var.resume_path
  depends_on             = [azurerm_storage_account_static_website.static_website]
}

