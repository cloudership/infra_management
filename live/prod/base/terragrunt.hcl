include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:cloudership/infra_tf_base.git?ref=v1.0.0-alpha.001"
}
