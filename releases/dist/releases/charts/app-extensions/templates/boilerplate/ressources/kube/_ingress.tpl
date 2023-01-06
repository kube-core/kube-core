{{- define "app-extensions.kube-ingress" -}}
{{- $name := (coalesce .value.name .key) }}
{{- $namespace := (coalesce .value.namespace "default") }}
{{- $domain := (coalesce .value.domain .common.cluster.config.domain) }}
{{- $host := (coalesce .value.host (printf "%s.%s.%s" $name $namespace $domain)) }}

apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ $name }}
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
    - host: {{ $host }}
      http:
        paths:
          - path: /
            pathType: ImplementationSpecific
            backend:
              service:
                name: {{ coalesce .value.serviceName $name }}
                port:
                  name: {{ coalesce .value.portName "http" }}
{{- end -}}
