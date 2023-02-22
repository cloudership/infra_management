locals {
  project_name = "showcase"
  root_domain  = "cloudership.com"
  env_account_ids = {
    build = "472822006607",
    prod = "697348095323",
  }
}

inputs = {
  project_name = local.project_name
  root_domain  = local.root_domain
  env_account_ids = local.env_account_ids
}
