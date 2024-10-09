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

dependency "base_eks" {
  config_path                             = "../base_eks"
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    main_cluster_name = "fake-cluster-name"
  }
}

terraform {
  source = "git::https://github.com/cloudership/infra_tf_apps.git?ref=v1.0.0"
}

inputs = {
  vpc_id                        = dependency.base.outputs.vpc_id
  rds_hostname                  = dependency.base.outputs.rds_hostname
  rds_port                      = dependency.base.outputs.rds_port
  alb_public_zone_id            = dependency.base.outputs.alb_public_zone_id
  alb_public_dns_name           = dependency.base.outputs.alb_public_dns_name
  alb_public_https_listener_arn = dependency.base.outputs.alb_public_https_listener_arn
  route53_zone_public_id        = dependency.base.outputs.route53_zone_public_id
  public_domain_prefix          = dependency.base.outputs.public_domain_prefix

  eks_cluster_main_name               = dependency.base_eks.outputs.eks_cluster_main_name
  eks_cluster_main_oidc_provider_name = dependency.base_eks.outputs.eks_cluster_main_oidc_provider_name
  eks_cluster_main_oidc_provider_arn  = dependency.base_eks.outputs.eks_cluster_main_oidc_provider_arn
  eks_cluster_main_sg_id              = dependency.base_eks.outputs.eks_cluster_main_sg_id
}
