{{- define "crossplane-cloud.globaladdress" -}}
{{ $name := (coalesce .value.name .key) }}
apiVersion: compute.gcp.upbound.io/v1beta1
kind: GlobalAddress
metadata:
  name: {{ $name }}
  annotations:
    crossplane.io/external-name: {{ coalesce .value.externalName $name }}
spec:
  deletionPolicy: {{ coalesce .value.deletionPolicy "Orphan" }}
  forProvider:
    addressType: {{ coalesce .value.addressType "EXTERNAL" }}
    ipVersion: {{ coalesce .value.ipVersion "IPV4" }}
  providerConfigRef:
    name: upbound-gcp
{{- end }}