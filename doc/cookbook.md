# Cookbook

Personal notes, HOWTOs, one-liners, and other helpful tidbits

## Turn it all on

```shell
for i in base base_eks apps; do AWS_PROFILE=Management bin/tg prod $i apply -auto-approve; done
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
