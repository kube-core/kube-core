{{- define "crossplane-cloud.managedsslcertificate" -}}
{{ $name := (coalesce .value.name .key) }}
apiVersion: compute.gcp.upbound.io/v1beta1
kind: ManagedSSLCertificate
metadata:
  name: {{ $name }}
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