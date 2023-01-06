{{- define "app-extensions.add-release-metadata-to-values" -}}
{{ $metadata := dict "name" .Release.Name "namespace" .Release.Namespace }}
{{ $_ := set .Values "release" $metadata }}
{{- end -}}
