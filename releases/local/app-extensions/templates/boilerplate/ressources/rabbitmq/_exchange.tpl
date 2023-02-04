{{- define "app-extensions.rabbitmq-exchange" -}}
{{- $name := (coalesce .value.name .key) }}
{{- $resourceName := (coalesce .value.resourceName .value.name .key) }}
{{ $rabbitmqClusterName := (coalesce .value.rabbitmqClusterName .common.release.name) }}
{{ $rabbitmqClusterNamespace := (coalesce .value.rabbitmqClusterNamespace .common.release.namespace) }}

apiVersion: rabbitmq.com/v1beta1
kind: Exchange
metadata:
  name: {{ $name }}
spec:
  name: {{ $name }}
  type: {{ coalesce .value.type "fanout" }} # default to 'direct' if not provided; can be set to 'direct', 'fanout', 'headers', and 'topic'
  autoDelete: {{ coalesce .value.autoDelete | default false }}
  durable: {{ coalesce .value.durable true }}
  rabbitmqClusterReference:
    name: {{ $rabbitmqClusterName }}
    namespace: {{ $rabbitmqClusterNamespace }}
  {{ if .value.arguments }}
  arguments: {{ toYaml .value.arguments | nindent 4 }}
  {{ end }}
{{ end }}
