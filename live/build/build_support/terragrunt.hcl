include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:cloudership/infra_tf_build_support.git?ref=ecr-repos"
}
