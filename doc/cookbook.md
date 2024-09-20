# Cookbook

Personal notes and one-liners and other helpful tidbits

## TODO

### Make installation of cert-manager more robust

https://cert-manager.io/docs/installation/kubectl/
https://artifacthub.io/packages/helm/cert-manager/cert-manager

Currently, Terraform installs the helm charts for cert-manager right after the LBC helm charts have finished deploying. This is not enough time some of the internals of LBC to "warm up" and become available, so cert-manager fails to install. Waiting a little while and retrying the installation of cert-manager then works.

### 

## Turn it all on

```shell
bin/tg prod base apply -auto-approve && bin/tg prod base_eks apply -auto-approve && bin/tg prod apps apply -auto-approve && bin/tg prod apps_k8s apply -auto-approve
```
