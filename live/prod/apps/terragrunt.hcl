include "root" {
  path = find_in_parent_folders()
}

dependency "base" {
  config_path = "../base"
}

terraform {
  source = "git::git@github.com:cloudership/infra_tf_apps.git?ref=master"
}
