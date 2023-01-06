{{- define "app-extensions.bucketpolicy" -}}
{{ $name := (coalesce .value.name .key) }}
apiVersion: storage.gcp.crossplane.io/v1alpha1
kind: BucketPolicy
metadata:
  name: {{ $name }}
  annotations:
    crossplane.io/external-name: {{ coalesce .value.externalName $name }}
spec:
  deletionPolicy: {{ coalesce .value.deletionPolicy "Orphan" }}
  forProvider:
    bucketRef:
      name: {{ coalesce .value.bucketRef $name }}
    policy:
      bindings:
      {{- if .value.public | default false }}
      - role: roles/storage.objectViewer
        members:
        - allUsers
      {{ end }}
      {{- if (not (eq .value.admin false)) }}
      - role: roles/storage.objectAdmin
        serviceAccountMemberRefs:
        - name: {{ coalesce .value.adminRef $name }}
      {{ end }}
      {{- if .value.roles }}
      {{- range .value.roles }}
      - {{ toYaml . | nindent 8 }}
      {{ end }}
      {{ end }}
  providerConfigRef:
    name: gcp
{{- end }}
