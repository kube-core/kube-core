{{- define "crossplane-cloud.globalforwardingrule" -}}
{{ $name := (coalesce .value.name .key) }}

apiVersion: compute.gcp.upbound.io/v1beta1
kind: GlobalForwardingRule
metadata:
  name: {{ $name }}
  annotations:
    crossplane.io/external-name: {{ coalesce .value.externalName $name }}
spec:
  deletionPolicy: {{ coalesce .value.deletionPolicy "Orphan" }}
  forProvider:
    loadBalancingScheme: {{ coalesce .value.loadBalancingScheme "EXTERNAL" }}
    {{ if eq .value.target.type "targetHttpProxies" }}
    target: global/targetHttpProxies/{{ .value.target.name | required ".value.target.name is required"}}
    portRange: "80"
    {{ else if eq .value.target.type "targetHttpsProxies" }}
    target: global/targetHttpsProxies/{{ .value.target.name | required ".value.target.name is required"}}
    portRange: "443"
    {{ end }}
    ipAddress: global/addresses/{{ .value.ipAddress | required ".value.ipAddress is required"}}
  providerConfigRef:
    name: upbound-gcp
{{- end }}