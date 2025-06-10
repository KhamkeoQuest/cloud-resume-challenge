variable "cloudflare_api_token" {
  type        = string
  description = "Cloudflare API token with permissions to manage DNS and Workers"
  sensitive   = true
}

variable "cloudflare_account_id" {
  description = "Cloudflare Account ID for deploying Workers"
  type        = string
}


variable "domain" {
  type        = string
  description = "The base domain (e.g., khamkeokhongsaly.com)"
}
