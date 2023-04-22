{{/*
Expand the name of the chart.
*/}}
{{- define "mongodb-managed.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mongodb-managed.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "mongodb-managed.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mongodb-managed.labels" -}}
helm.sh/chart: {{ include "mongodb-managed.chart" . }}
{{ include "mongodb-managed.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "mongodb-managed.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mongodb-managed.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "mongodb-managed.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "mongodb-managed.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the cluster role to use
*/}}
{{- define "mongodb-managed.roleName" -}}
{{- if .Values.rbac.role.create }}
{{- default (include "mongodb-managed.fullname" .) .Values.rbac.role.name }}
{{- else }}
{{- default "default" .Values.rbac.role.name }}
{{- end }}
{{- end }}

{{/*
Generate secretName created/used for each mongodb user, by iterating on user definition 
*/}}
{{- define "mongodb-managed.secretName" -}}
{{- printf "%s-%s-%s" (include "mongodb-managed.fullname" .global) (.user.db | default .user.name) (.user.name) -}}
{{- end -}}
