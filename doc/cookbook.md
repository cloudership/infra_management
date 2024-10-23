# Cookbook

Personal notes, HOWTOs, one-liners, and other helpful tidbits

## Turn it all on including K8s services

> [!NOTE]
> Use a Terragrunt source map for more dynamic setting of local sources, then enjoy parallelization

```shell
(set -euo pipefail; for i in base base_eks apps; do AWS_PROFILE=Management bin/tg prod $i apply -auto-approve; done) && AWS_PROFILE=Prod aws eks update-kubeconfig --name showcase-main --alias showcase-main --user-alias showcase-main && (set -euo pipefail; find ../infra_k8s_svc/live -name 'up' -perm +111 | while read i; do "${i}"; done)
```

## Create configmap manifests using JQ and key/value pairs from a file

Given a file `tmp/connection-information.json` contains:
```json
{
  "DB_USER": "user123",
  "DB_NAME": "frontend_app_qa"
}
```

Create a ConfigMap manifest with:

```shell
jq -n '{"apiVersion": "v1", "kind":"ConfigMap", "metadata":{"namespace":"apps","name":"frontend_app"}} + {"data": input}' tmp/connection-information.json
```

## Convert outputs from a component to JSON (ignoring sensitive values)

```shell
AWS_PROFILE=Management bin/tg prod base output -json | jq '. | with_entries(select(.value.sensitive == false)) | map_values(.value)'
```
