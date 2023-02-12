{{- define "app-extensions.gcp-managedsslcertificate" -}}
{{- $name := (coalesce .value.name .key) }}
{{- $resourceName := (coalesce .value.resourceName .value.name .key) }}
apiVersion: compute.gcp.upbound.io/v1beta1
kind: ManagedSSLCertificate
metadata:
  name: {{ $resourceName }}
  annotations:
    crossplane.io/external-name: {{ coalesce .value.externalName $name }}
spec:
  deletionPolicy: {{ coalesce .value.deletionPolicy "Orphan" }}
  forProvider:
    managed:
      - domains:
        {{- range .value.domains }}
        - {{ . }}
        {{- end }}
  providerConfigRef:
    name: upbound-gcp
{{- end }}
