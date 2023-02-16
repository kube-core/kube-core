{{- define "app-extensions.slack-channel" -}}
{{- $name := (coalesce .value.name .key) }}
{{- $resourceName := (coalesce .value.resourceName .value.name .key) }}
{{- $namespace := (coalesce .value.namespace "default") }}
{{- $resource := .value -}}
{{- $nameBase := (printf "%s-%s" $namespace $name) | kebabcase | replace ":" "-" }}

{{ if $resource.enabled }}
{{ $prefix := (coalesce .value.prefix "k8s") }}
{{ $channelName := (printf "%s-%s-%s" $prefix .common.cluster.config.name (coalesce .value.channelName $nameBase)) }}

apiVersion: slack.stakater.com/v1alpha1
kind: Channel
metadata:
  name: {{ $resourceName }}
  namespace: {{ $namespace }}
spec:
  name: {{ coalesce .value.channelNameOverride $channelName }}
  private: false
  topic: {{ coalesce .value.topic "none" }}
  description: {{ (coalesce .value.description (printf "Channel: %s" $channelName)) | quote }}
  {{- if .value.users }}
  users: {{ toYaml .value.users | nindent 4 }}
  {{- end -}}
{{- end -}}
{{- end -}}
