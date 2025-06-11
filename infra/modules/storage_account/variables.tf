variable "resource_group_name" {
  type = string
  description = "Name of the resource group where the storage account will be created"
}

variable "location" {
  type = string
  description = "Location for the storage account"
}

variable "tags" {
  type = map(string)
  default = {}
  description = "values to be used as tags for the storage account"
}

variable "project_name" {
  type = string
  description = "Name of the project, used as a prefix for the storage account name"
}

variable "environment" {
  type = string
  description = "Environment name, used as a suffix for the storage account name"
}