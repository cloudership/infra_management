# apps_k8s

## Purpose

Connect the world of OpenTofu to the world of Kubernetes by managing configmaps/secrets containing values from OpenTofu-managed resources, managing AWS IAM roles and policies for K8s service accounts.

Only simple K8s resources should generally be managed through TF, like namespaces and service accounts. Then, these should only in TF if other TF managed resources depend on them (this is especially true for namespaces). Do not manage applications and complex resources that use helm charts.
