variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type = map(string)
  description = "Tag map for the specific environment"
}


variable "index_path" {
  type        = string
  description = "Path to index.html"
}

variable "error_path" {
  type        = string
  description = "Path to 404.html"
}

variable "resume_path" {
  type        = string
  description = "Path to khamkeo_khongsaly_resume.html"
}
