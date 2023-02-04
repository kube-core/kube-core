{{- define "app-extensions.rabbitmq-user" -}}
{{- $name := (coalesce .value.name .key) }}
{{- $resourceName := (coalesce .value.resourceName .value.name .key) }}
{{ $rabbitmqClusterName := (coalesce .value.rabbitmqClusterName .common.release.name) }}
{{ $rabbitmqClusterNamespace := (coalesce .value.rabbitmqClusterNamespace .common.release.namespace) }}

apiVersion: rabbitmq.com/v1beta1
kind: User
metadata:
  name: {{ $name }}
spec:
{{- if .value.tags }}
  tags: {{ toYaml .value.tags | nindent 4 }}
{{- end }}
  rabbitmqClusterReference:
    name: {{ $rabbitmqClusterName }}
    namespace: {{ $rabbitmqClusterNamespace }}
  {{ if (.value.importCredentialsSecret) }}
  importCredentialsSecret:
  {{- if .value.secretNameOverride }}
    name: {{ .value.secretNameOverride }}
  {{- else }}
    name: rabbitmq-user-{{ $name }}-rabbitmq-cluster-{{ $rabbitmqClusterNamespace }}-{{ $rabbitmqClusterName }}-creds
  {{- end }}
  {{ end }}
{{ end }}
