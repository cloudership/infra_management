locals {
  project    = jsondecode(file(find_in_parent_folders("project.json")))
  env        = jsondecode(file(find_in_parent_folders("env.json")))
  account_id = local.project.env_account_ids[local.env.env_name]
}

remote_state {
  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }

  config = {
    bucket         = "com-mlops-showcase-${local.env.env_name}-${local.env.aws_region}-opentofu-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.env.aws_region
    encrypt        = true
    dynamodb_table = "${title(local.env.env_name)}OpentofuLocks"
  }
}

iam_role                 = "arn:aws:iam::${local.account_id}:role/OrganizationAccountAccessRole"
iam_assume_role_duration = 14400

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-HCL
    provider "aws" {
      region = var.aws_region

      default_tags {
        tags = {
          OpenTofu  = "true"
          Project   = var.project_name
          EnvName   = var.env_name
        }
      }
    }
  HCL
}

terraform {
  extra_arguments "vars" {
    commands = get_terraform_commands_that_need_vars()

    required_var_files = [
      find_in_parent_folders("project.json"),
      find_in_parent_folders("env.json"),
    ]

    optional_var_files = [
      "${get_parent_terragrunt_dir()}/local.tfvars"
    ]
  }
}
