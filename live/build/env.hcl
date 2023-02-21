locals {
  env_name         = "build"
  aws_region       = "eu-west-1"
}

inputs = {
  env_name   = local.env_name
  aws_region = local.aws_region
}
