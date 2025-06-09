output "static_site_url" {
  description = "The primary endpoint of the static website"
  value       = module.static_storage.static_storage_url
}

output "storage_account_name" {
  value = module.static_storage.storage_account_name
}

output "web_container_name" {
  value = "$web"
}

output "debug_index_path" {
  value = local.index_path
}

output "debug_resume_exists" {
  value = fileexists(local.resume_path)
}

output "resolved_resume_path" {
  value = abspath(local.resume_path)
}
