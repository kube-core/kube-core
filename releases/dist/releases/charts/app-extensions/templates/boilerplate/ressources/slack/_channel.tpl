{{- define "app-extensions.slack-channel" -}}
{{- $name := (coalesce .value.name .key) }}
{{- $resourceName := (coalesce .value.resourceName .value.channelName .value.name .key) }}
{{- $namespace := (coalesce .value.namespace "default") }}
{{- $resource := .value -}}
{{- $nameBase := (printf "%s-%s" $namespace $name) | kebabcase | replace ":" "-" }}

{{ if $resource.enabled }}
{{ $channelName := (coalesce .value.channelName $name) }}
apiVersion: slack.stakater.com/v1alpha1
kind: Channel
metadata:
  name: {{ $resourceName }}
  namespace: {{ $namespace }}
spec:
  name: {{ $channelName }}
  private: false
  topic: {{ coalesce .value.topic "none" }}
  description: {{ (coalesce .value.description (printf "Channel: %s" $channelName)) | quote }}
  {{- if .value.users }}
  users: {{ toYaml .value.users | nindent 4 }}
  {{- end -}}
{{- end -}}
{{- end -}}
