include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path   = "../env.hcl"
  expose = true
}

terraform {
  source = "tfr:///terraform-aws-modules/vpc/aws?version=3.18.1"
}

locals {
  vpc_cidr         = "${include.env.locals.subnet_address}/16"
  subnet_addresses = [for cidr_block in cidrsubnets(local.vpc_cidr, 1, 1) : cidrsubnets(cidr_block, 2, 2, 2)]
}

inputs = {
  name = "vpc"
  cidr = local.vpc_cidr

  azs             = formatlist("${include.env.locals.aws_region}%s", ["a", "b", "c"])
  private_subnets = local.subnet_addresses[0]
  public_subnets  = local.subnet_addresses[1]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    EnvName   = include.env.locals.env_name
    Component = "platform"
  }
}
