{{- define "app-extensions.prometheus-servicemonitor" -}}
{{- $name := (coalesce .value.name .key) }}
{{- $targetName := (coalesce .value.targetName .value.name .key) }}
{{- $resourceName := (coalesce .value.resourceName .value.name .key) }}
{{- $namespace := (coalesce .value.namespace "default") }}
{{- $resource := .value -}}
{{- $nameBase := (printf "%s_%s" (snakecase $namespace) (snakecase $name)) }}

{{ if $resource.enabled }}
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  name: {{ $resourceName }}
  namespace: {{ $namespace }}
spec:
  selector:
    {{ if $resource.labels }}
    matchLabels: {{ toYaml $resource.labels | nindent 6 }}
    {{ else }}
    matchLabels:
      release.kube-core.io/name: {{ $targetName }}
    {{ end }}
  endpoints: {{ toYaml $resource.endpoints | nindent 4 }}
{{- end -}}
{{- end -}}
