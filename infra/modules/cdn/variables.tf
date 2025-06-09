variable "project_name" {
  description = "The name of the project, used in naming resources"
  type        = string
}

variable "environment" {
  description = "The deployment environment (dev, stage, prod)"
  type        = string
}

variable "location" {
  description = "The Azure region for the CDN profile"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "blob_primary_web_host" {
  description = "The primary web endpoint of the blob storage static website (e.g., stresumedev.z20.web.core.windows.net)"
  type        = string
}
