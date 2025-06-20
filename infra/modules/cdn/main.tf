## We are not using the `azurerm_cdn_custom_domain` resource here because I'm using the free tier of Azure CDN, which does not support custom domains directly. 
## Instead, the CDN endpoint will be used with the blob storage origin.
## cloudflare_workers_script.resume_forwarder.name is the name of the Cloudflare Worker script that handles requests to the custom domain.

# This module sets up an Azure CDN profile and endpoint for serving static content from Azure Blob Storage.

resource "azurerm_cdn_profile" "cdn" {
  name                = "${var.project_name}-cdn-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard_Microsoft"
  tags                = var.tags
}

resource "azurerm_cdn_endpoint" "endpoint" {
  name                = "${var.project_name}-cdn-endpoint-${var.environment}"
  profile_name        = azurerm_cdn_profile.cdn.name
  location            = var.location
  resource_group_name = var.resource_group_name
  is_http_allowed     = false
  is_https_allowed    = true
  origin_host_header  = var.blob_primary_web_host

  origin {
    name      = "blob-origin-${var.environment}"
    host_name = var.blob_primary_web_host
  }

  tags = var.tags
}
