# MongoDB managed

![Version: 0.4.0](https://img.shields.io/badge/Version-0.4.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

MongoDB managed is a Helm chart that aims to deploy a MongoDB cluster using [MongoDB Community
Operator](https://github.com/mongodb/mongodb-kubernetes-operator) CRDs. The goal of this package is to simplify many
things :

- Automatically generate secret for a given user
- List only a list of users to generate associated secrets and database

## Requirements

- Mittwald secrets generator
- External secrets

| Repository | Name | Version |
|------------|------|---------|
| https://prometheus-community.github.io/helm-charts | mongodb-exporter(prometheus-mongodb-exporter) | 2.9.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| replicaCount | int | `3` |  |
| nameOverride | string | `""` |  |
| fullnameOverride | string | `""` |  |
| serviceAccount | object | `{"create":true}` | Create a service account for the operator god sake. |
| resources.limits | object | `{}` | Define pod limits. |
| resources.requests | object | `{}` | Define pod requests. |
| users | list | `[]` | Define the list of users. |
| mongodbMonitoring.user.create | bool | `true` |  |
| mongodbMonitoring.user.additionnalRoles | list | `[]` |  |
| mongodbMonitoring.externalSecrets.enabled | bool | `false` | Require external secrets set in cluster with a store in namespace |
| mongodb-exporter.enabled | bool | `true` | If enabled, proper value should be set to connect exporter to mongodb |
| mongodb-exporter.mongodb.uri | string | `"dummy-default"` | Default value set to permits exporter deployment without valid uri |
| mongodb-exporter.existingSecret.name | string | `""` | (REQUIRED) If using external secret, bootstrap with ".Release.Name-monitoring", or check notes. |
| mongodb-exporter.existingSecret.key | string | `"mongodb-uri"` |  |

### Users list definition

A user is a simple object using the following full template:

```yaml
- name: username # (required)
  db: database # (optional), if not provided, will be `{{ .name }}`.
  roles:
    - name: readWrite # (required)
      db: database # (optional), if not provided, will be as for username `{{ .db | default .name }}`
```

## Usage

### Installation

Installation with Helm :

```yaml
helm upgrade -i {release_name} neo9charts/mongodb-managed
```

Installation with Helmfile :

```yaml
releases:
  - name: {release_name}
    namespace: {namespace}
    chart: neo9charts/mongodb-managed
    version: 0.2.1
    values:
    - ./{path}
```

### Examples

```yaml
users:
  # Define a superuser.
  - name: a-superadmin-user
    db: admin
    roles:
      - name: clusterAdmin
      - name: userAdminAnyDatabase
      - name: readWriteAnyDatabase
      - name: dbAdminAnyDatabase

  # Define a regular user.
  - name: my-user
    roles:
      - name: readWrite
      - name: readWrite
        db: anotherDB
```
