output "static_site_url" {
  description = "The primary endpoint of the static website"
  value       = module.static_site.static_site_url
}

output "storage_account_name" {
  value = module.static_site.storage_account_name
}

output "web_container_name" {
  value = "$web"
}

output "debug_index_path" {
  value = module.shared.index_path
}
