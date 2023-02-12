{{- define "app-extensions.gcp-projectiamcustomrole" -}}
{{- $name := (coalesce .value.name .key) }}
{{- $resourceName := (coalesce .value.resourceName .value.name .key) }}
apiVersion: cloudplatform.gcp.jet.crossplane.io/v1alpha1
kind: ProjectIAMCustomRole
metadata:
  name: {{ $resourceName }}
  annotations:
    crossplane.io/external-name: projects/{{.common.cloud.project}}/roles/{{ coalesce .value.externalName $name }}
spec:
  deletionPolicy: {{ coalesce .value.deletionPolicy "Orphan" }}
  forProvider:
    project: {{ .common.cloud.project | required ".Values.cloud.project is required" }}
    permissions: {{ toYaml .value.permissions | nindent 4 }}
    roleId: {{ coalesce .value.externalName $name }}
    title: {{ coalesce .value.title $name }}
  providerConfigRef:
    name: jet-gcp
{{- end }}
