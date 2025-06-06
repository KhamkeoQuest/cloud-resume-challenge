locals {
  frontend_path = "${path.root}/frontend"

  index_path  = "${local.frontend_path}/index.html"
  error_path  = "${local.frontend_path}/404.html"
  resume_path = "${local.frontend_path}/khamkeo_khongsaly_resume.html"
}

