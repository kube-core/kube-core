{{- define "crossplane-cloud.managedzone" -}}
apiVersion: dns.gcp.upbound.io/v1beta1
kind: ManagedZone
metadata:
  name: {{ .value.dnsName | trimAll "." | replace "." "-" }}
spec:
  deletionPolicy: {{ coalesce .value.deletionPolicy "Orphan" }}
  forProvider:
    description: {{ .value.dnsName }}
    dnsName: {{ .value.dnsName }}
    labels:
      managed-by: crossplane
    visibility: {{ coalesce .value.visibility "public" }}
  providerConfigRef:
    name: upbound-gcp
{{- end }}
