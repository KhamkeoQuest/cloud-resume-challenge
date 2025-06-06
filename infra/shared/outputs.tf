# infra/shared/outputs.tf

output "project_name" {
  value = var.project_name
}

output "locations" {
  value = var.locations
}

output "tags" {
  value = var.tags
}

output "index_path" {
  value = local.index_path
}

output "error_path" {
  value = local.error_path
}

output "resume_path" {
  value = local.resume_path
}
