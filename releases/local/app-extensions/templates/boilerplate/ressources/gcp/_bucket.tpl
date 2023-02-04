{{- define "app-extensions.gcp-bucket" -}}
{{- $name := (coalesce .value.name .key) }}
{{- $resourceName := (coalesce .value.resourceName .value.name .key) }}
apiVersion: storage.gcp.crossplane.io/v1alpha3
kind: Bucket
metadata:
  name: {{ $resourceName }}
  annotations:
    crossplane.io/external-name: {{ coalesce .value.externalName $name }}
spec:
  deletionPolicy: {{ coalesce .value.deletionPolicy "Orphan" }}
  location: {{ coalesce .value.location .common.cloud.default.location }}
  {{- if (.value.uniformPolicy | default true) }}
  bucketPolicyOnly:
    enabled: true
  {{- end }}
  labels:
    managed-by: "crossplane"
    cluster: {{ .common.cluster.config.name }}
    {{- if .value.labels }}
    {{ toYaml (.value.labels) | nindent 4 }}
    {{- end }}
  providerConfigRef:
    name: gcp
{{- end }}
