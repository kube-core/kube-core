{{- define "app-extensions.sloth-prometheusservicelevel" -}}
{{- $name := (coalesce .value.name .key) }}
{{- $resourceName := (coalesce .value.resourceName .value.name .key) }}
{{- $namespace := (coalesce .value.namespace "default") }}
{{- $resource := .value -}}
{{- $nameBase := (printf "%s-%s" $namespace $name) | kebabcase | replace ":" "-" }}

{{ if $resource.enabled }}
apiVersion: sloth.slok.dev/v1
kind: PrometheusServiceLevel
metadata:
  name: {{ $name }}
  namespace: {{ $namespace }}
spec:
  service: {{ coalesce $resource.service $name }}
  labels:
    type: {{ coalesce $resource.type "app" }}
    app: {{ $name }}
    env: {{ coalesce $resource.env $namespace }}
  slos:
  {{ if $resource.ingress.enabled }}
    - name: "nginx-ingress-requests-availability"
      objective: {{ coalesce $resource.ingress.objective }}
      description: {{ $resource.ingress.description | quote }}
      sli:
        events:
          {{- $queryTemplate := "sum(rate(nginx_ingress_controller_request_duration_seconds_count{exported_namespace=\"%s\", ingress=\"%s\", status=~\"(5..|429)\"}[{{.window}}]))" }}
          {{- $query := coalesce $resource.errorQuery (printf $queryTemplate (coalesce $resource.namespace $namespace) (coalesce $resource.name $name)) }}
          errorQuery: {{ $query }}
          {{- $queryTemplate := "sum(rate(nginx_ingress_controller_request_duration_seconds_count{exported_namespace=\"%s\", ingress=\"%s\"}[{{.window}}]))" }}
          {{- $query := coalesce $resource.totalQuery (printf $queryTemplate (coalesce $resource.namespace $namespace) (coalesce $resource.name $name)) }}
          totalQuery: {{ $query }}
      alerting:
        name: {{ $name }}-nginx-ingress-high-error-rate
        labels:
          category: "availability"
          type: {{ coalesce $resource.type "app" }}
          app: {{ $name }}
          env: {{ coalesce $resource.env $namespace }}
        annotations:
          summary: {{ (coalesce $resource.ingress.alertDescription (printf "SLO: High error rate on '%s' nginx ingress requests responses" $name)) | quote }}
        pageAlert:
          disable: true
        ticketAlert:
          disable: true
  {{- end -}}
{{ range $sloName, $sloConfig := $resource.slos }}
    - name: {{ $sloName }}
      objective: {{ coalesce $sloConfig.objective }}
      description: {{ $sloConfig.description | quote }}
      sli:
        events:
          errorQuery: {{ $sloConfig.errorQuery }}
          totalQuery: {{ $sloConfig.totalQuery }}
      alerting:
        name: {{ $sloName }}
        labels:
          category: "custom"
          type: {{ coalesce $resource.type "app" }}
          app: {{ $name }}
          env: {{ coalesce $resource.env $namespace }}
        annotations:
          summary: {{ (coalesce $sloConfig.alertDescription $sloConfig.description) | quote }}
        pageAlert:
          disable: true
        ticketAlert:
          disable: true
{{- end }}
{{- end -}}
{{- end -}}
