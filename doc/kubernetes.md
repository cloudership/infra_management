# Using the EKS Kubernetes Cluster

## `kubectl` Access

Install the latest version of the `aws` command (e.g. `brew install awscli` or `pip/apt install aws-cli`, etc.) It must
be a modern version (e.g. >=2.20) - older versions are not supported.

Test access to EKS. With the appropriate profile/credentials, run:

```shell
aws eks describe-cluster --name showcase-main
```

To repeat: ensure the correct credentials (via profile or specifying AWS keys) are set in the environment first. Unlike
the infra_management project, they must be credentials for the AWS account in which the EKS cluster is hosted, not the
management account, e.g. the `Prod` account.

If an EKS cluster description is shown, proceed. Otherwise, configure AWS CLI access such that the above command works.

Create a `kubeconfig` (granting same AWS privileges as above aws command):

```shell
bin/setup-kubectl
# This runs the below command
aws eks update-kubeconfig --name showcase-main --alias showcase-main --user-alias showcase-main
```

This command can be repeated should anything change in the configuration that must be updated into the kubeconfig.
