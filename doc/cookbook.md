# Cookbook

Personal notes, HOWTOs, one-liners, and other helpful tidbits

## Turn it all on

```shell
for i in base base_eks apps apps_k8s; do AWS_PROFILE=Management bin/tg prod $i apply -auto-approve; done
```

## Create configmap manifests using JQ and key/value pairs from a file

Given a file `tmp/connection-information.json` contains:
```json
{
  "DB_USER": "mlflow",
  "DB_NAME": "mlflow"
}
```

Create a ConfigMap manifest with:

```shell
jq -n '{"apiVersion": "v1", "kind":"ConfigMap", "metadata":{"namespace":"apps","name":"mlflow"}} + {"data": input}' tmp/connection-information.json
```
