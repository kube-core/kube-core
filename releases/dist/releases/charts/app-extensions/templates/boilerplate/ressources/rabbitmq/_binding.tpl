{{- define "app-extensions.rabbitmq-binding" -}}
{{- $name := (coalesce .value.name .key) }}
{{- $resourceName := (coalesce .value.resourceName .value.name .key) }}
{{ $rabbitmqClusterName := (coalesce .value.rabbitmqClusterName .common.release.name) }}
{{ $rabbitmqClusterNamespace := (coalesce .value.rabbitmqClusterNamespace .common.release.namespace) }}

apiVersion: rabbitmq.com/v1beta1
kind: Binding
metadata:
  name: {{ $name }}
spec:
  source: {{ coalesce .value.source $name }}
  destination: {{ coalesce .value.destination $name }}
  destinationType: {{ coalesce .value.destinationType "queue" }} # can be 'queue' or 'exchange'
  rabbitmqClusterReference:
    name: {{ $rabbitmqClusterName }}
    namespace: {{ $rabbitmqClusterNamespace }}
{{ end }}
