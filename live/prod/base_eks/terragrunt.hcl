include "root" {
  path = find_in_parent_folders()
}

dependency "base" {
  config_path                             = "../base"
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    vpc_id             = "fake-vpc-id"
    subnet_ids         = ["1", "2"]
    fargate_subnet_ids = ["3", "4"]
  }
}

terraform {
  source = "git::git@github.com:cloudership/infra_tf_base.git//eks?ref=master"
}

inputs = {
  vpc_id             = dependency.base.outputs.vpc_id
  subnet_ids         = dependency.base.outputs.public_subnet_ids
  fargate_subnet_ids = dependency.base.outputs.private_subnet_ids
}
