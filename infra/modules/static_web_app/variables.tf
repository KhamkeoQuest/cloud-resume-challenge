variable "name" {}
variable "resource_group_name" {}
variable "location" {}
variable "sku_name" {
  default = "Free"
}
variable "repository_url" {}
variable "branch" {
  default = "main"
}
variable "app_location" {
  default = "frontend"
}
variable "output_location" {
  default = "frontend"
}
variable "tags" {
  default = {}
}
