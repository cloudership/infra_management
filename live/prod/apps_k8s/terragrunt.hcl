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

dependency "apps" {
  config_path                             = "../apps"
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    bucket_mlflow_name = "fake-mlflow-bucket"
    role_mlflow_arn    = "arn::fake"
  }
}

terraform {
  source = "git::https://github.com/cloudership/infra_tf_apps.git//k8s?ref=master"
}

inputs = {
  rds_hostname                        = dependency.base.outputs.rds_hostname
  rds_port                            = dependency.base.outputs.rds_port
  bucket_mlflow_name                  = dependency.apps.outputs.bucket_mlflow_name
  policy_mlflow_arn                   = dependency.apps.outputs.policy_mlflow_arn
  eks_cluster_main_name               = dependency.base_eks.outputs.eks_cluster_main_name
  eks_cluster_main_oidc_provider_name = dependency.base_eks.outputs.eks_cluster_main_oidc_provider_name
  eks_cluster_main_oidc_provider_arn  = dependency.base_eks.outputs.eks_cluster_main_oidc_provider_arn
}
