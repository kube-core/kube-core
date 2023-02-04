{{- define "app-extensions.rabbitmq-queue" -}}
{{- $name := (coalesce .value.name .key) }}
{{- $resourceName := (coalesce .value.resourceName .value.name .key) }}
{{ $rabbitmqClusterName := (coalesce .value.rabbitmqClusterName .common.release.name) }}
{{ $rabbitmqClusterNamespace := (coalesce .value.rabbitmqClusterNamespace .common.release.namespace) }}

apiVersion: rabbitmq.com/v1beta1
kind: Queue
metadata:
  name: {{ $name }}
spec:
  name: {{ $name }}
  autoDelete: {{ coalesce .value.autoDelete | default false }}
  durable: {{ coalesce .value.durable true }}
  type: {{ coalesce .value.type "quorum" }}
  rabbitmqClusterReference:
    name: {{ $rabbitmqClusterName }}
    namespace: {{ $rabbitmqClusterNamespace }}
{{ end }}
