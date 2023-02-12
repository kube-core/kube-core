{{- define "app-extensions.gcp-recordset" -}}
{{- $name := (coalesce .value.name .key) }}
{{- $resourceName := (coalesce .value.resourceName .value.name .key) }}
apiVersion: dns.gcp.upbound.io/v1beta1
kind: RecordSet
metadata:
  name: {{ $resourceName }}
  annotations:
    crossplane.io/external-name: {{ coalesce .value.externalName $name }}
    release.app-extensions.gcp-dns/record-type: "A"
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
