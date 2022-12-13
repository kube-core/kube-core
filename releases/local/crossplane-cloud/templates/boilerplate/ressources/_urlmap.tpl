{{- define "crossplane-cloud.urlmap" -}}
{{ $name := (coalesce .value.name .key) }}

apiVersion: compute.gcp.upbound.io/v1beta1
kind: URLMap
metadata:
  name: {{ $name }}
  annotations:
    crossplane.io/external-name: {{ coalesce .value.externalName $name }}
spec:
  deletionPolicy: {{ coalesce .value.deletionPolicy "Orphan" }}
  forProvider:
    hostRule:
      {{- range .value.hostRule }}
      - hosts:
        {{- range .hosts }}
        - {{ . }}
        {{- end }}
        pathMatcher: {{ .pathMatcher }}
      {{- end }}
    pathMatcher:
      {{- range .value.pathMatcher }}
      - defaultService: projects/{{ $.common.cloud.project }}/global/backendBuckets/{{ .defaultService }}
        name: {{ .name }}
      {{- end }}
  providerConfigRef:
    name: upbound-gcp

{{- end }}