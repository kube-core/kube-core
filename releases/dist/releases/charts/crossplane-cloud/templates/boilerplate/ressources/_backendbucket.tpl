{{- define "crossplane-cloud.backendbucket" -}}
{{ $name := (coalesce .value.name .key) }}
apiVersion: compute.gcp.upbound.io/v1beta1
kind: BackendBucket
metadata:
  name: {{ $name }}
  annotations:
    crossplane.io/external-name: {{ coalesce .value.externalName $name }}
spec:
  deletionPolicy: {{ coalesce .value.deletionPolicy "Orphan" }}
  forProvider:
    bucketName: {{ .value.bucketName | required "Need to specify name of the source bucket" }}
    enableCdn: {{ coalesce .value.enableCdn "true" }}
  providerConfigRef:
    name: upbound-gcp
{{- end }}