include "root" {
  path = find_in_parent_folders()
}

include "project" {
  path   = "../../project.hcl"
  expose = true
}

include "env" {
  path   = "../env.hcl"
  expose = true
}

terraform {
  source = "git::git@github.com:cloudership/infra_tf_base.git?ref=v1.0.0-alpha.001"
}

prevent_destroy = true

inputs = {
  vpc_subnet_address   = include.env.locals.subnet_address
  vpc_subnet_mask_bits = include.env.locals.subnet_mask_bits
}
