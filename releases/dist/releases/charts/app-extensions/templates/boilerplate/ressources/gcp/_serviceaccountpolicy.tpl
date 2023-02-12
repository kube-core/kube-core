{{- define "app-extensions.gcp-serviceaccountpolicy" -}}
{{- $name := (coalesce .value.name .key) }}
{{- $resourceName := (coalesce .value.resourceName .value.name .key) }}
apiVersion: iam.gcp.crossplane.io/v1alpha1
kind: ServiceAccountPolicy
metadata:
  name: {{ $resourceName }}
  annotations:
    crossplane.io/external-name: {{ coalesce .value.externalName $name }}
spec:
  deletionPolicy: {{ coalesce .value.deletionPolicy "Orphan" }}
  forProvider:
    serviceAccountRef:
      name: {{ coalesce $.value.sa $name }}
    policy:
      bindings:
      {{- if (not (eq (.value.defaultRole) false)) }}
      - role: {{ coalesce .value.role (printf "projects/%s/roles/%s" $.common.cloud.project $name) }}
        serviceAccountMemberRefs:
        - name: {{ coalesce .value.sa $name }}
      {{ end }}
      {{- if .value.defaultRoles }}
      {{ range .value.defaultRoles }}
      - role: {{ . }}
        serviceAccountMemberRefs:
        - name: {{ coalesce $.value.sa $name }}
      {{ end }}
      {{ end }}
      {{- if .value.roles }}
      {{- range .value.roles }}
      - {{ toYaml . | nindent 8 }}
      {{ end }}
      {{ end }}
  providerConfigRef:
    name: gcp
{{- end }}
