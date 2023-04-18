{{- define "app-extensions.kube-ingress" -}}
{{- $name := (coalesce .value.name .key) }}
{{- $resourceName := (coalesce .value.resourceName .value.name .key) }}
{{- $namespace := (coalesce .value.namespace "default") }}
{{- $domain := (coalesce .value.domain .common.cluster.config.domain) }}
{{- $subDomainBase := $namespace }}
{{- if .value.subDomainBase }}
{{- $subDomainBase = .value.subDomainBase }}
{{- end }}
{{- $nameTemplate := printf "%s.%s" $name $namespace -}}
{{- if eq $name $namespace }}
{{- $nameTemplate = $name }}
{{- end }}
{{- $host := (coalesce .value.host (printf "%s.%s.%s" (coalesce .value.subDomain $nameTemplate) $subDomainBase $domain)) }}
{{- if .value.subDomainOverride }}
{{- $host = (coalesce .value.host (printf "%s.%s" .value.subDomainOverride $domain)) }}
{{- end }}
{{- $path := (coalesce .value.path "/") }}
{{- $pathType := (coalesce .value.pathType "ImplementationSpecific") }}

apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ $resourceName }}
  namespace: {{ $namespace }}
  labels:
    {{- with .value.labels }}
      {{- toYaml . | nindent 4 }}
    {{- end }}
  annotations:
    {{- with .value.annotations }}
      {{- toYaml . | nindent 4 }}
    {{- end }}
spec:
  ingressClassName: {{ coalesce .value.ingressClassName "nginx" }}
  {{- if (.value.tls) }}
  tls:
    - hosts:
      - {{ $host }}
      {{- if .value.customSecretName }}
      secretName: {{ .value.customSecretName }}
      {{- else }}
      secretName: {{ $host | replace "." "-" }}-tls
      {{- end }}
  {{- end }}
  rules:
  {{- if .value.defaultRules }}
  - host: {{ $host }}
    http:
      paths:
        - path: {{ $path }}
          pathType: {{ $pathType }}
          backend:
            service:
              name: {{ coalesce .value.serviceName $name }}
              port:
                {{- if (not .value.portNumber) }}
                name: {{ coalesce .value.portName "http" }}
                {{- else }}
                number: {{ .value.portNumber }}
                {{- end }}
  {{- end -}}
  {{- if .value.customRules }}
  {{- range .value.customRules }}
  - {{ toYaml . | nindent 4 | trim }}
  {{- end -}}
  {{- end -}}
{{- end -}}
