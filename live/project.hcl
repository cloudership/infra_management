locals {
  project_name     = "showcase"
  root_domain      = "cloudership.com"
  enable_expensive = true
}

inputs = {
  project_name     = local.project_name
  root_domain      = local.root_domain
  enable_expensive = local.enable_expensive
}
