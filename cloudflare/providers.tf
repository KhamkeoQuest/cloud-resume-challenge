terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0" # or the version you want
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
