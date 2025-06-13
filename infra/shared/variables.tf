variable "environments" {
  type    = list(string)
  default = ["dev", "stage", "prod"]
}

variable "locations" {
  type = map(string)
  default = {
    dev   = "East US 2"
    stage = "Central US"
    prod  = "West US 2"
  }
}

variable "project_name" {
  type    = string
  default = "resume"
}

variable "tags" {
  description = "Default tags per environment"
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

variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID"
}

variable "env_short" {
  type = map(string)
  default = {
    dev   = "dev"
    stage = "stg"
    prod  = "prd"
  }
}

variable "loc_short" {
  type = map(string)
  default = {
    "East US 2"   = "eus2"
    "Central US"  = "cus"
    "West US 2"   = "wus2"
  }
}
