{{- define "app-extensions.gcp-projectiammember" -}}
{{- $name := (coalesce .value.name .key) }}
{{- $resourceName := (coalesce .value.resourceName .value.name .key) }}
apiVersion: cloudplatform.gcp.upbound.io/v1beta1
kind: ProjectIAMMember
metadata:
  name: {{ $resourceName }}
  annotations:
    crossplane.io/external-name: {{ coalesce .value.externalName $name }}
spec:
  deletionPolicy: {{ coalesce .value.deletionPolicy "Orphan" }}
  forProvider:
    member: serviceAccount:{{ coalesce .value.member $name }}@{{ .common.cloud.project }}.iam.gserviceaccount.com
    project: {{ .common.cloud.project | required ".Values.cloud.project is required" }}
    role: {{ coalesce .value.role (printf "projects/%s/roles/%s" .common.cloud.project ($name | kebabcase | replace "-" "." | untitle)) }}
  providerConfigRef:
    name: upbound-gcp
{{- end }}
