{{- define "app-extensions.rabbitmq-permission" -}}
{{- $name := (coalesce .value.name .key) }}
{{- $resourceName := (coalesce .value.resourceName .value.name .key) }}
{{ $rabbitmqClusterName := (coalesce .value.rabbitmqClusterName .common.release.name) }}
{{ $rabbitmqClusterNamespace :=  (coalesce .value.rabbitmqClusterNamespace .common.release.namespace) }}

apiVersion: rabbitmq.com/v1beta1
kind: Permission
metadata:
  name: {{ $name }} # {{ $name }}-{{ if (eq (coalesce .value.vhost "/") "/")}}root{{ else }}{{ .value.vhost }}{{ end }}
spec:
  vhost: {{ (coalesce .value.vhost "/") | quote }}
  {{ if .value.userName }}
  user: "{{ (coalesce .value.userName $name) }}"
  {{ else }}
  userReference:
    name: {{ coalesce .value.userRef $name }}
  {{ end }}
  {{ if .value.customPermissions }}
  permissions: {{ toYaml .value.customPermissions | nindent 4 }}
  {{ else }}
  permissions:
  {{ if (or .value.write .value.configure .value.read) }}
    {{- if .value.write }}
    write: ".*"
    {{ end -}}
    {{- if .value.configure }}
    configure: ".*"
    {{ end -}}
    {{- if .value.read }}
    read: ".*"
    {{ end }}
  {{ else }}
    read: ".*"
  {{ end }}
  {{ end }}
  rabbitmqClusterReference:
    name: {{ $rabbitmqClusterName }}
    namespace: {{ $rabbitmqClusterNamespace }}
{{ end }}
