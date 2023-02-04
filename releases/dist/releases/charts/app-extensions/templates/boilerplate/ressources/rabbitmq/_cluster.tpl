{{- define "app-extensions.rabbitmq-cluster" -}}
{{- $name := (coalesce .value.name .key) }}
{{- $resourceName := (coalesce .value.resourceName .value.name .key) }}
{{- $namespace := (coalesce .value.namespace "default") }}

apiVersion: rabbitmq.com/v1beta1
kind: RabbitmqCluster
metadata:
  name: {{ $name }}
spec:
  replicas: {{ coalesce .value.replicas 1 }}
  persistence:
    storage: {{ coalesce .value.storageSize "10Gi" }}
    {{ if .value.storageClassName }}
    storageClassName: {{ .value.storageClassName }}
    {{ end }}
  {{ if .value.rabbitmq }}
  rabbitmq: {{ toYaml .value.rabbitmq | nindent 4 }}
  {{ else }}
  rabbitmq:
    additionalConfig: |
      log.console.level = error
      prometheus.return_per_object_metrics = true
  {{ end }}
  {{- with .value.extraSpec }}
    {{- toYaml . | nindent 2 }}
  {{- end }}
  override:
    # service:
    #   metadata:
    #     name: {{ $name }}-rabbitmq-server
    statefulSet:
      spec:
        template:
          metadata:
            # name: {{ $name }}-rabbitmq-server
            labels:
              logging.kube-core.io/flow-name: {{ coalesce .value.logFlow "app" }}
{{ end }}
