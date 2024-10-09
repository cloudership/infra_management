include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/cloudership/infra_tf_base.git?ref=v1.1.0"
}
