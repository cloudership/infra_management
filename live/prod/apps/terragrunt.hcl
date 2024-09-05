include "root" {
  path = find_in_parent_folders()
}

dependency "base" {
  config_path                             = "../base"
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    rds_hostname = "dbhost"
    rds_port     = 5432
  }
}

terraform {
  source = "git::git@github.com:cloudership/infra_tf_apps.git?ref=master"
}

inputs = {
  rds_hostname = dependency.base.outputs.rds_hostname
  rds_port     = dependency.base.outputs.rds_port
}
