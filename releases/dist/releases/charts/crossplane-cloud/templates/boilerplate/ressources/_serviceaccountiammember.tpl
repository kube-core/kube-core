{{- define "crossplane-cloud.serviceaccountiammember" -}}
{{ $name := (coalesce .value.name .key) }}
apiVersion: cloudplatform.gcp.upbound.io/v1beta1
kind: ServiceAccountIAMMember
metadata:
  name: {{ $name }}
  annotations:
    crossplane.io/external-name: {{ coalesce .value.externalName $name }}
spec:
  deletionPolicy: {{ coalesce .value.deletionPolicy "Orphan" }}
  forProvider:
    member: serviceAccount:{{ $name }}@{{ $.common.cloud.project }}.iam.gserviceaccount.com
    role: {{ coalesce .value.role (printf "projects/%s/roles/%s" $.common.cloud.project $name) }}
    serviceAccountIdRef:
      name: {{ coalesce .value.sa $name }}
  providerConfigRef:
    name: upbound-gcp
{{- end }}