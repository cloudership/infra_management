# Cookbook

Personal notes and one-liners and other helpful tidbits

## TODO

### kubectl auto-configure

Configure kubectl automatically after creating eks cluster using
https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec

## Turn it all on

```shell
bin/tg prod base apply -auto-approve && bin/tg prod base_eks apply -auto-approve && bin/tg prod apps apply -auto-approve && AWS_PROFILE=Prod aws eks update-kubeconfig --name showcase-main --alias showcase-main --user-alias showcase-main && bin/tg prod apps_k8s apply -auto-approve
```
