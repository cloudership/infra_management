include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "git::https://github.com/cloudership/infra_tf_base.git//domains?ref=v1.0.0"
}
