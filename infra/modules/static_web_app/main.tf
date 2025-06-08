resource "azurerm_static_site" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku_name = var.sku_name

  repository_url         = var.repository_url
  branch                 = var.branch
  build_properties {
    app_location    = var.app_location    # e.g., "frontend"
    output_location = var.output_location # e.g., "frontend"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}
