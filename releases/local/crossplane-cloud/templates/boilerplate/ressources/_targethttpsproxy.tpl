{{- define "crossplane-cloud.targethttpsproxy" -}}
{{ $name := (coalesce .value.name .key) }}

apiVersion: compute.gcp.upbound.io/v1beta1
kind: TargetHTTPSProxy
metadata:
  name: {{ $name }}
  annotations:
    crossplane.io/external-name: {{ coalesce .value.externalName $name }}
spec:
  deletionPolicy: {{ coalesce .value.deletionPolicy "Orphan" }}
  forProvider:
    sslCertificates:
      {{ range .value.managedSslCertificates | required ".value.managedSslCertificates is required" }}
      - {{ . }}
      {{ end }}
    urlMap: {{ .value.urlMap | required ".value.urlMap is required" }}
  providerConfigRef:
    name: upbound-gcp
    
{{- end }}