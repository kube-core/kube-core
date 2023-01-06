{{- define "app-extensions.rabbitmq-cluster" -}}
{{- $name := (coalesce .value.name .key) }}
{{ $rabbitmqClusterName := (coalesce .value.rabbitmqClusterName .common.release.name) }}
{{ $rabbitmqClusterNamespace := (coalesce .value.rabbitmqClusterNamespace .common.release.namespace) }}

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
