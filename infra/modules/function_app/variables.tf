variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "short_location" {
  type = string
}

variable "cosmosdb_endpoint" {
  description = "Cosmos DB endpoint"
  type        = string
}

variable "cosmosdb_primary_key" {
  description = "Cosmos DB primary key"
  type        = string
}

variable "tags" {
  description = "Tags for Azure resources"
  type        = map(string)
}