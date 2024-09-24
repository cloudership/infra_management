# TODO

## Gen own certs for LBC

One-liner to generate cert and keys:

```shell
openssl req -x509 -newkey ed25519 -sha256 -days 3650   -nodes -keyout lbc.key -out lbc.crt -subj "/CN=aws-load-balancer-webhook-service.kube-system.svc.cluster.local"   -addext "subjectAltName=DNS:aws-load-balancer-webhook-service.kube-system.svc.cluster.local,DNS:aws-load-balancer-webhook-service.kube-system.svc"
```

Doesn't generate the CA cert though.

Interesting helm chart options:

| Parameter           | Description                                                                                                                                | Default |
|---------------------|--------------------------------------------------------------------------------------------------------------------------------------------|---------|
| `enableCertManager` | If enabled, cert-manager issues the webhook certificates instead of the helm template, requires cert-manager and it's CRDs to be installed | `false` |
| `webhookTLS.caCert` | TLS CA certificate for webhook (auto-generated if not provided)                                                                            | ""      |
| `webhookTLS.cert`   | TLS certificate for webhook (auto-generated if not provided)                                                                               | ""      |
| `webhookTLS.key`    | TLS private key for webhook (auto-generated if not provided)                                                                               | ""      |
| `keepTLSSecret`     | Reuse existing TLS Secret during chart upgrade                                                                                             |         |

Maybe we don't need to faff around with our own certs!
