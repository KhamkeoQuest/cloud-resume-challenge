data "cloudflare_zone" "main" {
  name = var.domain
}

resource "cloudflare_workers_script" "resume_forwarder" {
  name       = "resume-forwarder"
  account_id = var.cloudflare_account_id
  content    = file("${path.module}/worker.js")
}


resource "cloudflare_workers_route" "resume_route" {
  zone_id     = data.cloudflare_zone.main.id
  pattern     = "resume.khamkeokhongsaly.com/*"
  script_name = cloudflare_workers_script.resume_forwarder.name
}

resource "cloudflare_workers_route" "www_route" {
  zone_id     = data.cloudflare_zone.main.id
  pattern     = "www.khamkeokhongsaly.com/*"
  script_name = cloudflare_workers_script.resume_forwarder.name
}

