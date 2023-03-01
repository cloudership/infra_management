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
  source = "git::git@github.com:cloudership/infra_tf_build_support.git?ref=master&kick=1"
}

prevent_destroy = true

inputs = {
}
