variable "environments" {
  type    = list(string)
  default = ["dev", "stage", "prod"]
}

variable "locations" {
  type    = map(string)
  default = {
    dev   = "East US"
    stage = "Central US"
    prod = "West US 3"
  }
}

variable "project_name" {
  type    = string
  default = "resume"
}

variable "tags" {
  description = "Tag map per environment"
  type = map(map(string))
  default = {
    dev = {
      environment = "dev"
      project     = "cloud-resume"
      source      = "terraform"
    }
    stage = {
      environment = "stage"
      project     = "cloud-resume"
      source      = "terraform"
    }
    prod = {
      environment = "prod"
      project     = "cloud-resume"
      source      = "terraform"
    }
  }
}

variable "frontend_path" {
  type        = string
  description = "Base path to the frontend assets"
  default     = "${path.module}/frontend"
}
variable "index_path" {
  type        = string
  description = "Path to index.html"
  default     = "${var.frontend_path}/index.html"
}
variable "error_path" {
  type        = string
  description = "Path to 404.html"
  default     = "${var.frontend_path}/404.html"
}
variable "resume_path" {
  type        = string
  description = "Path to resume.pdf"
  default     = "${var.frontend_path}/khamkeo_khongsaly_resume.html"
}

