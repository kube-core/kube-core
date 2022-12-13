{{- define "crossplane-cloud.targethttpproxy" -}}
{{ $name := (coalesce .value.name .key) }}
apiVersion: compute.gcp.upbound.io/v1beta1
kind: TargetHTTPProxy
metadata:
  name: {{ $name }}
  annotations:
    crossplane.io/external-name: {{ coalesce .value.externalName $name }}
spec:
  deletionPolicy: {{ coalesce .value.deletionPolicy "Orphan" }}
  forProvider:
    urlMap: {{ .value.urlMap | required ".value.urlMap is required" }}
  providerConfigRef:
    name: upbound-gcps
{{- end }}