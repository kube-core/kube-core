{{- define "crossplane-cloud.recordset" -}}
{{ $name := (coalesce .value.name .key) }}

apiVersion: dns.gcp.upbound.io/v1beta1
kind: RecordSet
metadata:
  name: {{ $name }}
  annotations:
    crossplane.io/external-name: {{ coalesce .value.externalName $name }}
    release.crossplane-cloud.dns/record-type: "A"
spec:
  deletionPolicy: {{ coalesce .value.deletionPolicy "Orphan" }}
  forProvider:
    managedZone: {{ .value.managedZone | required ".value.managedZone is required" }}
    name: {{ .value.rootDnsName | required ".value.rootDnsName is required" }}
    {{- if .value.rrdatas }}
    rrdatas:
    {{- range .value.rrdatas }}
    - {{ . }}
    {{- end }}
    {{- end }}
    type: {{ coalesce .value.type "A" }}
  providerConfigRef:
    name: upbound-gcp

{{- end }}