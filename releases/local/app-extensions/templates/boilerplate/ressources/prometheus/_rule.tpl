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
  {{ if (or $resource.cpuAvg.enabled $resource.memoryAvg.enabled $resource.ingressAccessFreq.enabled $resource.serviceAccessFreq.enabled $resource.ingressControllerAccessFreq.enabled) }}
  - name: {{ $name }}-hpa-app.rules
    rules:
    {{- if $resource.cpuAvg.enabled }}
    {{- $metricName := coalesce $resource.cpuAvg.metricName (printf "%s_cpu_usage_ratio" $nameBase) }}
    {{- $queryTemplate := "rate(container_cpu_usage_seconds_total{namespace=\"%s\", pod=~\"%s-.*\", image!=\"\", container=\"%s\"}[%s])" }}
    {{ $podQuery := (coalesce $resource.cpuAvg.podQuery $name) }}
    {{ if $resource.namespaceSuffix }}
    {{ $podQuery = printf "%s-%s" $podQuery $namespace }}
    {{ end }}
    {{- $query := coalesce $resource.cpuAvg.query (printf $queryTemplate (coalesce $resource.cpuAvg.namespace $namespace) $podQuery (coalesce $resource.cpuAvg.container $name) (coalesce $resource.cpuAvg.window)) }}
    - expr: {{ $query }}
      record: {{ $metricName }}
    {{- end }}

    {{- if $resource.memoryAvg.enabled }}
    {{- $metricName := coalesce $resource.memoryAvg.metricName (printf "%s_memory_usage_ratio" $nameBase) }}
    {{- $queryTemplate := "sum(container_memory_working_set_bytes{namespace=\"%s\", pod=~\"%s-.*\", image!=\"\", container=\"%s\"}) / sum(cluster:namespace:pod_memory:active:kube_pod_container_resource_requests{namespace=\"%s\", pod=~\"%s-.*\", container=\"%s\"})" }}
    {{ $podQuery := (coalesce $resource.memoryAvg.podQuery $name) }}
    {{ if $resource.namespaceSuffix }}
    {{ $podQuery = printf "%s-%s" $podQuery $namespace }}
    {{ end }}
    {{- $query := coalesce $resource.memoryAvg.query (printf $queryTemplate (coalesce $resource.memoryAvg.namespace $namespace) $podQuery (coalesce $resource.memoryAvg.container $name) (coalesce $resource.memoryAvg.namespace $namespace) $podQuery (coalesce $resource.memoryAvg.container $name)) }}
    - expr: {{ $query }}
      record: {{ $metricName }}
    {{- end }}

    {{- if $resource.ingressAccessFreq.enabled }}
    {{- $metricName := coalesce $resource.ingressAccessFreq.metricName (printf "%s_ingress_access_frequency" $nameBase) }}
    {{- $queryTemplate := "sum(rate(nginx_ingress_controller_requests{exported_namespace=\"%s\", ingress=\"%s\"}[%s]))" }}
    {{ $ingressName := (coalesce $resource.ingressAccessFreq.name $name) }}
    {{ if $resource.namespaceSuffix }}
    {{ $ingressName = printf "%s-%s" $ingressName $namespace }}
    {{ end }}
    {{- $query := coalesce $resource.ingressAccessFreq.query (printf $queryTemplate (coalesce $resource.ingressAccessFreq.namespace $namespace) $ingressName (coalesce $resource.ingressAccessFreq.window)) }}
    - expr: {{ $query }}
      record: {{ $metricName }}
    {{- end }}

    {{- if $resource.ingressControllerAccessFreq.enabled }}
    {{- $metricName := coalesce $resource.ingressControllerAccessFreq.metricName (printf "%s_ingress_controller_access_frequency" $nameBase) }}
    {{- $queryTemplate := "sum(rate(nginx_ingress_controller_nginx_process_requests_total{controller_namespace=\"%s\", controller_class=\"%s\"}[%s]))" }}
    {{ $controllerClass := (coalesce $resource.ingressControllerAccessFreq.controllerClass "nginx") }}
    {{ if $resource.namespaceSuffix }}
    {{ if $resource.ingressControllerAccessFreq.istio }}
    {{ $controllerClass = printf "k8s.io/ingress-nginx-istio-%s" $namespace }}
    {{ else }}
    {{ $controllerClass = printf "k8s.io/ingress-nginx-%s" $namespace }}
    {{ end }}
    {{ else }}
    {{ if $resource.ingressControllerAccessFreq.istio }}
    {{ $controllerClass = "k8s.io/ingress-nginx-istio" }}
    {{ else }}
    {{ $controllerClass = "k8s.io/ingress-nginx" }}
    {{ end }}
    {{ end }}

    {{- $query := coalesce $resource.ingressControllerAccessFreq.query (printf $queryTemplate (coalesce $resource.ingressControllerAccessFreq.namespace $namespace) $controllerClass (coalesce $resource.ingressControllerAccessFreq.window)) }}
    - expr: {{ $query }}
      record: {{ $metricName }}
    {{- end }}

    {{- if $resource.serviceAccessFreq.enabled }}
    {{- $metricName := coalesce $resource.serviceAccessFreq.metricName (printf "%s_service_access_frequency" $nameBase) }}
    {{- $queryTemplate := "sum(rate(http_requests_total{service=\"%s\", namespace=\"%s\"}[%s]))" }}
    {{ $serviceName := (coalesce $resource.serviceAccessFreq.name $name) }}
    {{ if $resource.namespaceSuffix }}
    {{ $serviceName = printf "%s-%s" $serviceName $namespace }}
    {{ end }}
    {{- $query := coalesce $resource.serviceAccessFreq.query (printf $queryTemplate $serviceName (coalesce $resource.serviceAccessFreq.namespace $namespace) (coalesce $resource.serviceAccessFreq.window)) }}
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
