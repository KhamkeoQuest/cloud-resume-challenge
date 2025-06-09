output "cdn_endpoint_hostname" {
  description = "The hostname of the CDN endpoint (e.g., *.azureedge.net)"
  value       = azurerm_cdn_endpoint.endpoint.host_name
}

output "cdn_endpoint_url" {
  description = "The full URL of the CDN endpoint"
  value       = "https://${azurerm_cdn_endpoint.endpoint.host_name}"
}
