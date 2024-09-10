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

dependency "apps" {
  config_path                             = "../apps"
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    bucket_mlflow_name = "fake-mlflow-bucket"
  }
}

generate "k8s_provider" {
  path      = "k8s_provider.tf"
  if_exists = "overwrite_terragrunt"

  # Assumes cluster name has the default configuration as described here:
  # https://github.com/cloudership/infra_management/blob/master/doc/kubernetes.md#kubectl-access
  contents = <<-HCL
    provider "kubernetes" {
      config_path    = "~/.kube/config"
      config_context = "showcase-main"
    }
  HCL
}

terraform {
  source = "git::https://github.com/cloudership/infra_tf_apps_k8s.git?ref=master"
}

inputs = {
  rds_hostname       = dependency.base.outputs.rds_hostname
  rds_port           = dependency.base.outputs.rds_port
  bucket_mlflow_name = dependency.apps.outputs.bucket_mlflow_name
}
