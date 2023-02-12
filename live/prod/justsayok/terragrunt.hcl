locals {
  revision = get_env("justsayok_revision", "master")
}

include "root" {
  path = find_in_parent_folders()
}

include "project" {
  path   = "../../project.hcl"
  expose = true
}

include "env" {
  path   = "../env.hcl"
  expose = true
}

dependency "base" {
  config_path = "../base"
}

terraform {
  source = "git::git@github.com:cloudership/infra_tf_service.git?ref=${local.revision}"
}

prevent_destroy = true

inputs = {
  service_name = "justsayok"
  port         = 3000
  arch         = "ARM64"

  image = {
    name = "cloudership/justsayok"
    tag  = "latest"
  }

  vpc_id                      = dependency.base.outputs.vpc_id
  subnet_ids                  = dependency.base.outputs.public_subnet_ids
  public_alb                  = dependency.base.outputs.public_alb
  ecs_cluster_arn             = dependency.base.outputs.ecs_cluster_default_arn
  ecs_task_execution_role_arn = dependency.base.outputs.ecs_task_execution_role_arn
  public_zone_id              = dependency.base.outputs.route53_zone_public_id
}
