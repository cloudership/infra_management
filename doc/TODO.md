# TODO

## MLflow: install with Helm

Create a chart for mlflow, add the official Helm distribution as a subchart, and add TargetGroupBinding in top-level chart, so it can be deployed as a single unit

## MLflow: hardcode resource names, don't depend on TF plumbing

This makes things much simpler as all K8s resources can be created from this project.

This includes letting the Helm distro create the service account, and customizing it with the correct annotations to assign it the right role.

## Airflow: customize using custom Helm chart

Create custom Helm chart, add official distribution as dependency, and add TargetGroupBinding in custom chart, so they can all be deployed as a single unit

https://airflow.apache.org/docs/helm-chart/stable/extending-the-chart.html
