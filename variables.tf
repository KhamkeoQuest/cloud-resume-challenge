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

locals {
  frontend_path = "${path.module}/frontend"

  index_path  = "${local.frontend_path}/index.html"
  error_path  = "${local.frontend_path}/404.html"
  resume_path = "${local.frontend_path}/khamkeo_khongsaly_resume.html"
}
