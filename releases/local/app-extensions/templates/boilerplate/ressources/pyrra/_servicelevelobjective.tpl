{{- define "app-extensions.pyrra-servicelevelobjective" -}}
{{- $name := (coalesce .value.name .key) }}
{{- $resourceName := (coalesce .value.resourceName .value.name .key) }}
{{- $targetName := (coalesce .value.targetName .value.name .key) }}
{{- $namespace := (coalesce .value.namespace "default") }}
{{- $resource := .value -}}
{{- $nameBase := (printf "%s-%s" $namespace $name) | kebabcase | replace ":" "-" }}
{{- $ingressErrorQueryTemplate := "nginx_ingress_controller_requests{exported_namespace=\"%s\", ingress=\"%s\", status=~\"(5..|429)\"}" }}
{{- $ingressErrorQuery := (printf $ingressErrorQueryTemplate $namespace $targetName) }}
{{- $ingressTotalQueryTemplate := "nginx_ingress_controller_requests{exported_namespace=\"%s\", ingress=\"%s\"}" }}
{{- $ingressTotalQuery := (printf $ingressTotalQueryTemplate $namespace $targetName) }}


{{- $serviceErrorQueryTemplate := "http_requests_total{service=\"%s\", namespace=\"%s\", code=~\"(5..|429)\"}" }}
{{- $serviceErrorQuery := (printf $serviceErrorQueryTemplate $targetName $namespace ) }}
{{- $serviceTotalQueryTemplate := "http_requests_total{service=\"%s\", namespace=\"%s\"}" }}
{{- $serviceTotalQuery := (printf $serviceTotalQueryTemplate $targetName $namespace ) }}

{{- $appErrorQueryTemplate := "http_request_duration_seconds_count{service=\"%s\", namespace=\"%s\", code=~\"(5..|429)\"}" }}
{{- $appErrorQuery := (printf $appErrorQueryTemplate $targetName $namespace ) }}
{{- $appTotalQueryTemplate := "http_request_duration_seconds_count{service=\"%s\", namespace=\"%s\"}" }}
{{- $appTotalQuery := (printf $appTotalQueryTemplate $targetName $namespace ) }}

{{- $targetType := $resource.targetType }}
{{- $errorQuery := "" }}
{{- $totalQuery := "" }}
{{- if (eq $targetType "ingress") }}
{{- $errorQuery = $ingressErrorQuery }}
{{- $totalQuery = $ingressTotalQuery }}
{{- else if (eq $targetType "service") }}
{{- $errorQuery = $serviceErrorQuery }}
{{- $totalQuery = $serviceTotalQuery }}
{{- else if (eq $targetType "app") }}
{{- $errorQuery = $appErrorQuery }}
{{- $totalQuery = $appTotalQuery }}
{{- end }}
{{- $errorQuery = (coalesce $resource.errorQuery $errorQuery) }}
{{- $totalQuery = (coalesce $resource.totalQuery $totalQuery) }}
{{- $successQuery := (coalesce $resource.successQuery) }}

{{ if $resource.enabled }}
apiVersion: pyrra.dev/v1alpha1
kind: ServiceLevelObjective
metadata:
  name: {{ $resourceName }}
  namespace: {{ $namespace }}
  labels:
    pyrra.dev/env: {{ $namespace }} # Any labels prefixed with 'pyrra.dev/' will be propagated as Prometheus labels, while stripping the prefix.
    pyrra.dev/app: {{ $targetName }}
    pyrra.dev/resource: {{ $resourceName }}
    pyrra.dev/name: {{ $name }}
spec:
  target: {{ $resource.target | quote }}
  window: {{ $resource.window | quote }}
  description: {{ $resource.description | quote }}
  indicator:
    {{ $resource.indicatorType }}:
      {{ if $successQuery }}
      success:
        metric: {{ $successQuery }}
      {{ end }}
      {{ if $errorQuery }}
      errors:
        metric: {{ $errorQuery }}
      {{ end }}
      {{ if $totalQuery }}
      total:
        metric: {{ $totalQuery }}
      {{ end }}
      {{ if $resource.grouping }}
      grouping: {{ toYaml $resource.grouping | nindent 8 }}
      {{ end }}
{{- end -}}
{{- end -}}
