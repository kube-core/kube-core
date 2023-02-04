{{- define "app-extensions.prometheus-rule" -}}
{{- $name := (coalesce .value.name .key) }}
{{- $resourceName := (coalesce .value.resourceName .value.name .key) }}
{{- $namespace := (coalesce .value.namespace "default") }}
{{- $resource := .value -}}
{{- $nameBase := (printf "%s_%s" (snakecase $namespace) (snakecase $name)) }}

{{ if $resource.enabled }}
apiVersion: monitoring.coreos.com/v1
kind: PrometheusRule
metadata:
  name: {{ $resourceName }}
  namespace: {{ $namespace }}
spec:
  groups:
  {{ if (or $resource.cpuAvg.enabled $resource.memoryAvg.enabled $resource.ingressAccessFreq.enabled $resource.serviceAccessFreq.enabled) }}
  - name: {{ $name }}-hpa-app.rules
    rules:
    {{- if $resource.cpuAvg.enabled }}
    {{- $metricName := coalesce $resource.cpuAvg.metricName (printf "%s_%s_cpu_usage_ratio" $nameBase) }}
    {{- $queryTemplate := "rate(container_cpu_usage_seconds_total{namespace=\"%s\", pod=~\"%s-.*\", image!=\"\", container=\"%s\"}[%s])" }}
    {{- $query := coalesce $resource.cpuAvg.query (printf $queryTemplate (coalesce $resource.cpuAvg.namespace $namespace) (coalesce $resource.cpuAvg.podQuery $name) (coalesce $resource.cpuAvg.container $name) (coalesce $resource.cpuAvg.window)) }}
    - expr: {{ $query }}
      record: {{ $metricName }}
    {{- end }}

    {{- if $resource.memoryAvg.enabled }}
    {{- $metricName := coalesce $resource.memoryAvg.metricName (printf "%s_%s_memory_usage_ratio" $nameBase) }}
    {{- $queryTemplate := "sum(container_memory_working_set_bytes{namespace=\"%s\", pod=~\"%s-.*\", image!=\"\", container=\"%s\"}) / sum(cluster:namespace:pod_memory:active:kube_pod_container_resource_requests{namespace=\"%s\", pod=~\"%s-.*\", container=\"%s\"})" }}
    {{- $query := coalesce $resource.memoryAvg.query (printf $queryTemplate (coalesce $resource.memoryAvg.namespace $namespace) (coalesce $resource.memoryAvg.podQuery $name) (coalesce $resource.memoryAvg.container $name) (coalesce $resource.memoryAvg.namespace $namespace) (coalesce $resource.memoryAvg.podQuery $name) (coalesce $resource.memoryAvg.container $name)) }}
    - expr: {{ $query }}
      record: {{ $metricName }}
    {{- end }}

    {{- if $resource.ingressAccessFreq.enabled }}
    {{- $metricName := coalesce $resource.ingressAccessFreq.metricName (printf "%s_%s_ingress_access_frequency" $nameBase) }}
    {{- $queryTemplate := "sum(rate(nginx_ingress_controller_requests{exported_namespace=\"%s\", ingress=\"%s\"}[%s]))" }}
    {{- $query := coalesce $resource.ingressAccessFreq.query (printf $queryTemplate (coalesce $resource.ingressAccessFreq.namespace $namespace) (coalesce $resource.ingressAccessFreq.podQuery $name) (coalesce $resource.ingressAccessFreq.window)) }}
    - expr: {{ $query }}
      record: {{ $metricName }}
    {{- end }}

    {{- if $resource.serviceAccessFreq.enabled }}
    {{- $metricName := coalesce $resource.serviceAccessFreq.metricName (printf "%s_service_access_frequency" $nameBase) }}
    {{- $queryTemplate := "sum(rate(http_requests_total{service=\"%s\", namespace=\"%s\"}[%s]))" }}
    {{- $query := coalesce $resource.serviceAccessFreq.query (printf $queryTemplate (coalesce $resource.serviceAccessFreq.name $name) (coalesce $resource.serviceAccessFreq.namespace $namespace) (coalesce $resource.serviceAccessFreq.window)) }}
    - expr: {{ $query }}
      record: {{ $metricName }}
    {{- end }}
{{- end }}
{{- if $resource.rules }}
  - name: {{ $name }}-hpa.rules
    rules: {{ toYaml $resource.rules | nindent 4 }}
{{- end }}

{{- if (and $resource.rabbitmq.enabled (or (coalesce $resource.rabbitmq.queues.scaling false) $resource.rabbitmq.queues.default)) }}
  - name: {{ $name }}-hpa-rabbitmq.rules
    rules:
    {{- if $resource.rabbitmq.queues.default }}
    {{- $metricName := (printf "%s_%s_rabbitmq_in_messages" $nameBase) }}
    {{- $queryTemplate := "rabbitmq_queue_messages{namespace=\"%s\", service!=\"\", queue=\"%s.%s.in\"}" }}
    {{- $query := (printf $queryTemplate ($namespace) ($namespace) ($name)) }}
    - expr: {{ $query }}
      record: {{ $metricName }}
    {{- $metricName := (printf "%s_%s_rabbitmq_out_messages" $nameBase) }}
    {{- $queryTemplate := "rabbitmq_queue_messages{namespace=\"%s\", service!=\"\", queue=\"%s.%s.out\"}" }}
    {{- $query := (printf $queryTemplate ($namespace) ($namespace) ($name)) }}
    - expr: {{ $query }}
      record: {{ $metricName }}
    {{ end }}
    {{- if $resource.rabbitmq.queues.scaling }}
    {{- range $key, $value := $resource.rabbitmq.queues.scaling }}
    {{- $metricName := (printf "%s_rabbitmq_%s_queue_messages" $nameBase $value.name) }}
    {{- $queryTemplate := "rabbitmq_queue_messages{namespace=\"%s\", service!=\"\", queue=\"%s\"}" }}
    {{- $query := (printf $queryTemplate ($namespace) ($value.name)) }}
    - expr: {{ $query }}
      record: {{ $metricName }}
    {{- end }}
    {{- end }}
{{- end -}}

{{- end -}}
{{- end -}}
