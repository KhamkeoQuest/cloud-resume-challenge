variable "project_name" {
  description = "Logical name of the project used in naming Azure resources."
  type        = string
}

variable "environment" {
  description = "Environment name such as dev, stage, or prod."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Azure resource group to deploy the static web app into."
  type        = string
}

variable "location" {
  description = "Azure region where the static web app will be deployed."
  type        = string
}

variable "sku_name" {
  description = "Pricing tier of the Azure Static Web App. Default is Free."
  type        = string
  default     = "Free"
}

variable "tags" {
  description = "Map of tags to apply to the Azure Static Web App."
  type        = map(string)
  default     = {}
}


variable "branch" {
  description = "(Optional) GitHub branch to watch for changes (used only with advanced integration)."
  type        = string
  default     = "main"
}

variable "app_location" {
  description = "Path to the application source code within the repo. Default is 'frontend'."
  type        = string
  default     = "frontend"
}

variable "output_location" {
  description = "Output directory from the build process. Default is 'frontend'."
  type        = string
  default     = "frontend"
}
