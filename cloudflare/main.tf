data "cloudflare_zone" "main" {
  name = var.domain
}

resource "cloudflare_worker_script" "resume_forwarder" {
  name       = "resume-forwarder"
  account_id = var.cloudflare_account_id
  content    = file("${path.module}/worker.js")
}


resource "cloudflare_worker_route" "resume_route" {
  zone_id     = data.cloudflare_zone.main.id
  pattern     = "resume.${var.domain}/*"
  script_name = cloudflare_worker_script.resume_forwarder.name
}

resource "cloudflare_worker_route" "www_route" {
  zone_id     = data.cloudflare_zone.main.id
  pattern     = "www.${var.domain}/*"
  script_name = cloudflare_worker_script.resume_forwarder.name
}
