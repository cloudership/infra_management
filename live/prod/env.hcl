locals {
  env_name       = "prod"
  aws_region     = "eu-west-1"
  subnet_address = "10.5.0.0"
}

inputs = {
  env_name   = local.env_name
  aws_region = local.aws_region
}
