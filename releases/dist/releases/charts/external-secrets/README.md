![External secrets](https://banners.beyondco.de/External%20secrets.png?theme=light&packageManager=&packageName=neo9charts%2Fexternal-secrets+&pattern=architect&style=style_1&description=External+secrets+wrapper&md=1&showWatermark=1&fontSize=100px&images=lock-closed)
![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.5.3](https://img.shields.io/badge/AppVersion-0.5.3-informational?style=flat-square)

# Externel secrets

This Helm chart is a parent-chart for [External Secrets Operator](https://external-secrets.io/v0.5.3/). It simplifies
the process by generating `ServiceAccount`, `SecretStore` and `ClusterSecretStore` automatically for a given namespace.

External secrets is an operator which build secrets from `Configmap` and raw data using templating variables provided by
other secrets (please see usage for more informations).

## Chart requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.external-secrets.io | external-secrets | 0.5.3 |

## Chart values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| stores.kubernetes.namespaces | string | `nil` |  |
| stores.kubernetes.serviceAccount.create | bool | `true` |  |
| stores.kubernetes.serviceAccount.name | string | `"external-secrets-kubernetes-store"` |  |

## Usage

**Warning: During the first deployment, be sure to not provide any `namespaces` because the operator publishes its own CRDs. You
need to wait a bit for CRDs to be installed before trying to add `ClusterSecretStore`.**

```yaml
# values.yaml

stores:
  kubernetes:
    namespaces:
      - integration # `ClusterSecretStore<k8s-integration>`
      - validation  # `ClusterSecretStore<k8s-validation>`

# Configure external-secrets directly.
external-secrets: {}
```

```yaml
# secret.yaml

kind: ConfigMap
apiVersion: v1
metadata:
  name: catalogue-akeneo-api-external-secret-template
data:
  MONGODB_URI: mongodb://{{ .mongodb_username }}:{{ .mongodb_password }}@catalogue-mongodb-svc/{{ .mongodb_username }}?replicaSet=catalogue-mongodb
  RABBITMQ_URI: amqp://{{ .rabbitmq_username }}:{{ .rabbitmq_password }}@catalogue-rabbitmq/catalogue

---

apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: catalogue-akeneo-api
spec:
  refreshInterval: "1m"
  secretStoreRef:
    name: k8s-integration # matches namespace `integration`
    kind: ClusterSecretStore
  target:
    creationPolicy: Merge
    template:
      templateFrom:
        - configMap:
            name: catalogue-akeneo-api-external-secret-template
            items:
              - key: MONGODB_URI
              - key: RABBITMQ_URI
        - configMap:
            name: catalogue-elasticsearch-external-secret-template
            items:
              - key: ELASTICSEARCH_URI
  data:
    - secretKey: mongodb_username
      remoteRef:
        key: catalogue-mongodb-catalogue-akeneo-api-catalogue-akeneo-api
        property: username
    - secretKey: mongodb_password
      remoteRef:
        key: catalogue-mongodb-catalogue-akeneo-api-catalogue-akeneo-api
        property: password
    - secretKey: rabbitmq_username
      remoteRef:
        key: catalogue-rabbitmq-user-akeneo-api-user-credentials
        property: username
    - secretKey: rabbitmq_password
      remoteRef:
        key: catalogue-rabbitmq-user-akeneo-api-user-credentials
        property: password
```

For more information, see [the official documentation](https://external-secrets.io/v0.5.3/guides-templating/).
