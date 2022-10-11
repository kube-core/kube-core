![RabbitMQ managed](https://banners.beyondco.de/RabbitMQ%20Managed.png?theme=light&packageManager=&packageName=neo9charts%2Frabbitmq-managed+&pattern=architect&style=style_1&description=Deploy+RabbitMQ+with+easy&md=1&showWatermark=1&fontSize=100px&images=dots-circle-horizontal)
![Version: 0.2.0](https://img.shields.io/badge/Version-0.2.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

# RabbitMQ managed

RabbitMQ managed is a simple Helm chart which aims to simplify RabbitMQ cluster deployment using the [RabbitMQ Operator
](https://www.rabbitmq.com/kubernetes/operator/operator-overview.html) CRDs.

## Chart definition

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| nameOverride | string | `""` |  |
| fullnameOverride | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.className | string | `"nginx"` |  |
| ingress.annotations."cert-manager.io/cluster-issuer" | string | `"letsencrypt-dns-production-gcp"` |  |
| ingress.annotations."external-dns.alpha.kubernetes.io/ttl" | string | `"5"` |  |
| ingress.annotations."ingress.neo9.io/access-operator-enabled" | string | `"true"` |  |
| ingress.annotations."ingress.neo9.io/allowed-visitors" | string | `"self,neo9,neo9-sf"` |  |
| ingress.annotations."nginx.ingress.kubernetes.io/force-ssl-redirect" | string | `"true"` |  |
| ingress.annotations."nginx.ingress.kubernetes.io/proxy-body-size" | string | `"200m"` |  |
| ingress.annotations."nginx.ingress.kubernetes.io/ssl-redirect" | string | `"true"` |  |
| ingress.annotations."nginx.org/client-max-body-size" | string | `"200m"` |  |
| ingress.labels."ingress.neo9.io/access-operator-enabled" | string | `"true"` |  |
| ingress.host | string | `"example.test"` | Define the hostname to use. |
| ingress.tls.enabled | bool | `true` | Enabled Tls, create a secret by default |
| ingress.tls.customSecretName | string | `""` | Specify existing secret if no automated provisionning |
| cluster.replicaCount | int | `1` |  |
| cluster.extraSpec | object | `{}` | Add values directly into spec of RabbitmqCluster manifests |
| vhosts | list | `[]` |  |
| users | list | `[]` |  |

### Users list definition

```yaml
- name: admin
  tags: ["administrator"] # (optional)
  importCredentialsSecret: # This will simply import credentials into `{release-name}-user-{user}-user-credentials` (optional)
    name: my-secret-name # (optional)
  permissions:
    - vhost: custom-vhost
      write: ".*"     # (optional)
      configure: ".*" # (optional)
      read: ".*"      # (optional)
```

## Usage

```yaml
# Define the list of vhosts.
# The default vhost (`/`) is automatically created, you don't need to specify it here.
vhosts:
- catalogue

# Define the list of users.
users:
- name: admin
  tags: ["administrator"]
  permissions:
    - vhost: /

- name: catalogue-cms-api
  permissions:
    - vhost: catalogue
```

### Secrets management

All passwords are automatically generated except if you specified `importCredentialsSecret` user's property. But, the
final secret will be stored using the following standard naming convention :
`{release_name}-user-{user:name}-user-credentials`.
