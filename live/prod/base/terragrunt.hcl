include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path   = "../env.hcl"
  expose = true
}

terraform {
  source = "git::git@github.com:cloudership/infra_tf_base.git?ref=master"
}

prevent_destroy = true

inputs = {
  project_name         = "showcase"
  env_name             = include.env.locals.env_name
  vpc_subnet_address   = include.env.locals.subnet_address
  vpc_subnet_mask_bits = 16
}
