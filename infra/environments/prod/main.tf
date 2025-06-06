# prod/main.tf

module "shared" {
  source = "../../shared"
}

locals {
  frontend_path = "${path.root}/../../../frontend"
  index_path    = "${local.frontend_path}/index.html"
  error_path    = "${local.frontend_path}/404.html"
  resume_path   = "${local.frontend_path}/khamkeo_khongsaly_resume.html"
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${module.shared.project_name}-${var.environment}"
  location = module.shared.locations[var.environment]
  tags     = module.shared.tags[var.environment]
}

module "static_site" {
  source              = "../../modules/storage_static_site"
  project_name        = module.shared.project_name
  environment         = var.environment
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = module.shared.tags[var.environment]
  index_path          = local.index_path
  error_path          = local.error_path
  resume_path         = local.resume_path
}
