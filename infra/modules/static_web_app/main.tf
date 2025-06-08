resource "azurerm_static_web_app" "static_web_app" {
  name                = "swa-${var.project_name}-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location

  sku_size = var.sku_name

  tags = var.tags
}
