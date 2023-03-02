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
    bucket         = "com-cloudership-showcase-${local.env.env_name}-management"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.env.aws_region
    encrypt        = true
    dynamodb_table = "TerraformLocks"
  }
}

iam_role                 = "arn:aws:iam::${local.account_id}:role/OrganizationAccountAccessRole"
iam_assume_role_duration = 900
prevent_destroy          = true

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-HCL
    provider "aws" {
      region = var.aws_region

      default_tags {
        tags = {
          Terraform = "true"
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
