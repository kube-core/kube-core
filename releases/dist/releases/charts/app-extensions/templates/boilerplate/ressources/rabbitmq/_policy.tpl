{{- define "app-extensions.rabbitmq-policy" -}}
{{- $name := (coalesce .value.name .key) }}
{{- $resourceName := (coalesce .value.resourceName .value.name .key) }}
{{ $rabbitmqClusterName := (coalesce .value.rabbitmqClusterName .common.release.name) }}
{{ $rabbitmqClusterNamespace := (coalesce .value.rabbitmqClusterNamespace .common.release.namespace) }}

apiVersion: rabbitmq.com/v1beta1
kind: Policy
metadata:
  name: {{ $name }}
spec:
  name: {{ $name }}
  vhost: {{ coalesce .value.vhost $name }}
  pattern: {{ coalesce .value.pattern ".*" }}
  applyTo: {{ coalesce .value.applyTo "all" }}
  {{ if .value.definition }}
  definition: {{ toYaml .value.definition | nindent 4 }}
  {{ else }}
  definition:
    ha-mode: all
    ha-sync-mode: automatic
  {{ end }}
  rabbitmqClusterReference:
    name: {{ $rabbitmqClusterName }}
    namespace: {{ $rabbitmqClusterNamespace }}
{{ end }}
