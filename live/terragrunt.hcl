locals {
  env_config = read_terragrunt_config("../env.hcl")
}

remote_state {
  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }

  config = {
    bucket         = "com-cloudership-showcase-${local.env_config.inputs.env_name}-management"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "${local.env_config.inputs.aws_region}"
    encrypt        = true
    dynamodb_table = "TerraformLocks"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<-EOT
    provider "aws" {
      region = "${local.env_config.inputs.aws_region}"

      default_tags {
        tags = {
          Terraform = "true"
          Project   = var.project_name
          EnvName   = var.env_name
        }
      }
    }
  EOT
}

terraform {
  extra_arguments "vars" {
    commands = get_terraform_commands_that_need_vars()



    optional_var_files = [
      "${get_parent_terragrunt_dir()}/local.tfvars"
    ]
  }
}
