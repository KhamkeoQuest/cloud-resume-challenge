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
  description = "Region in normalized format, e.g. eastus, centralus"
}


variable "tags" {
  type = map(string)
}

variable "cosmosdb_endpoint" {
  type = string
  description = "Cosmos DB endpoint"
}

variable "cosmosdb_primary_key" {
  type = string
  description = "Cosmos DB primary key"
}
