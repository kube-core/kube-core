{{- define "app-extensions.keda-scaledobject" -}}
{{- $name := (coalesce .value.name .key) }}
{{- $resourceName := (coalesce .value.resourceName .value.name .key) }}
{{- $namespace := (coalesce .value.namespace "default") }}
{{- $resource := .value -}}
{{- $monitoring := .value.monitoring }}
{{- $nameBase := (printf "%s_%s" (snakecase $namespace) (snakecase $name)) }}

{{ if $resource.enabled }}
apiVersion: keda.sh/v1alpha1
kind: ScaledObject
metadata:
  name: {{ $name }}
  namespace: {{ $namespace }}
spec:
  scaleTargetRef:
    apiVersion: {{ $resource.scaleTargetRef.apiVersion }}
    kind: {{ $resource.scaleTargetRef.kind }}
    {{ if (eq $resource.namespaceSuffix true) }}
    name: {{ $resource.scaleTargetRef.name }}-{{ $resource.namespace }}
    {{ else }}
    name: {{ $resource.scaleTargetRef.name }}
    {{ end }}
  minReplicaCount: {{ $resource.minReplicaCount }}
  maxReplicaCount: {{ $resource.maxReplicaCount }}
  triggers:
  {{- range $resource.extraTriggers }}
  - {{- toYaml . | nindent 4 }}
  {{- end }}

  {{ range $triggerName, $triggerConfig := $resource.extraPrometheusTriggers }}
  {{ if $triggerConfig.enabled }}
  {{ $metricName := (printf "%s_%s" $nameBase ((coalesce $triggerConfig.name $triggerName) | snakecase)) }}
  - type: prometheus
    metricType: {{ coalesce $triggerConfig.metricType "Value" }}
    metadata:
      serverAddress: {{ $resource.prometheusEndpoint }}
      metricName: {{ $metricName }}
      threshold: {{ coalesce $triggerConfig.threshold 1 | quote }}
      query: {{ (coalesce $triggerConfig.query $metricName) | quote }}
  {{ end }}
  {{ end }}

  {{- if $resource.rabbitmq.enabled }}

  {{- range $key, $value := $resource.rabbitmq.queues }}
  - type: prometheus
    metricType: Value
    metadata:
      serverAddress: {{ $resource.prometheusEndpoint }}
      metricName: "{{ $nameBase }}_rabbitmq_{{ snakecase $name }}_queue_messages"
      threshold: {{ coalesce $value.threshold 1 | quote }}
      query: "{{ $nameBase }}_rabbitmq_{{ snakecase $name }}_queue_messages"
  {{- end }}

  {{- if $monitoring.rules.rabbitmq.queues.default }}
  - type: prometheus
    metricType: Value
    metadata:
      serverAddress: {{ $resource.prometheusEndpoint }}
      metricName: "{{ $nameBase }}_rabbitmq_in_queue_messages"
      threshold: {{ $resource.rabbitmq.default.in 1 | quote }}
      query: "{{ $nameBase }}_rabbitmq_in_queue_messages"
  - type: prometheus
    metadata:
      serverAddress: {{ $resource.prometheusEndpoint }}
      metricName: "{{ $nameBase }}_rabbitmq_out_queue_messages"
      threshold: {{ $resource.rabbitmq.default.out 1 | quote }}
      query: "{{ $nameBase }}_rabbitmq_out_queue_messages"
  {{- end }}

  {{- end }}

  {{- if $resource.memoryAvg.enabled }}
  {{- $metricName := coalesce $resource.memoryAvg.metricName (printf "%s_memory_usage_ratio" $nameBase) }}
  {{- $query := coalesce $resource.memoryAvg.query (printf "avg(%s)" $metricName) }}
  - type: prometheus
    metricType: Value
    metadata:
      serverAddress: {{ $resource.prometheusEndpoint }}
      metricName: {{ $metricName }}
      threshold: {{ coalesce $resource.memoryAvg.threshold | quote }}
      query: {{ $query }}
  {{- end }}

  {{- if $resource.cpuAvg.enabled }}
  {{- $metricName := coalesce $resource.cpuAvg.metricName (printf "%s_cpu_usage_ratio" $nameBase) }}
  {{- $query := coalesce $resource.cpuAvg.query (printf "avg(%s)" $metricName) }}
  - type: prometheus
    metricType: Value
    metadata:
      serverAddress: {{ $resource.prometheusEndpoint }}
      metricName: {{ $metricName }}
      threshold: {{ coalesce $resource.cpuAvg.threshold | quote }}
      query: {{ $query }}
  {{- end }}

  {{- if $resource.ingressAccessFreq.enabled }}
  {{- $metricName := coalesce $resource.ingressAccessFreq.metricName (printf "%s_ingress_access_frequency" $nameBase) }}
  {{- $query := coalesce $resource.ingressAccessFreq.query $metricName }}
  - type: prometheus
    metadata:
      serverAddress: {{ $resource.prometheusEndpoint }}
      metricName: {{ $metricName }}
      threshold: {{ coalesce $resource.ingressAccessFreq.threshold | quote }}
      query: {{ $query }}
  {{- end }}

  {{- if $resource.ingressControllerAccessFreq.enabled }}
  {{- $metricName := coalesce $resource.ingressControllerAccessFreq.metricName (printf "%s_ingress_controller_access_frequency" $nameBase) }}
  {{- $query := coalesce $resource.ingressControllerAccessFreq.query $metricName }}
  - type: prometheus
    metadata:
      serverAddress: {{ $resource.prometheusEndpoint }}
      metricName: {{ $metricName }}
      threshold: {{ coalesce $resource.ingressControllerAccessFreq.threshold | quote }}
      query: {{ $query }}
  {{- end }}

  {{- if $resource.serviceAccessFreq.enabled }}
  {{- $metricName := coalesce $resource.serviceAccessFreq.metricName (printf "%s_service_access_frequency" $nameBase) }}
  {{- $query := coalesce $resource.serviceAccessFreq.query $metricName }}
  - type: prometheus
    metadata:
      serverAddress: {{ $resource.prometheusEndpoint }}
      metricName: {{ $metricName }}
      threshold: {{ coalesce $resource.serviceAccessFreq.threshold | quote }}
      query: {{ $query }}
  {{- end }}
{{ end }}

{{- end -}}
