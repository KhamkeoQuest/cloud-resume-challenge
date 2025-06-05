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
    }
    stage = {
      environment = "stage"
      project     = "cloud-resume"
    }
    prod = {
      environment = "prod"
      project     = "cloud-resume"
    }
  }
}
