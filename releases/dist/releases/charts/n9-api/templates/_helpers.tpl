{{/*
Define the deployed environnement of the pod.
*/}}
{{- define "n9-api.deployedEnv" -}}
{{- default .Release.Namespace ( default .Values.global.deployedEnv .Values.api.deployedEnv ) }}
{{- end }}

{{/*
Create an app name used to identify the app deployed by a release
Trimprefix the name namespace of the namespace if present in the release name
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "n9-api.name" -}}
{{- if .Values.name.appNameOverride }}
{{- .Values.name.appNameOverride | trunc 63 | trimSuffix "-" }}
{{- else if contains .Release.Namespace .Release.Name }}
{{- trimPrefix ( printf "%s-" ( include "n9-api.deployedEnv" . ) ) (printf .Release.Name ) | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{/*
Create a default fully qualified app name, that's used to name kubernetes ressources.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "n9-api.fullname" -}}
{{- default ( include "n9-api.name" . ) .Values.name.templatedNameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create an app version as used by labels or deployment
*/}}
{{- define "n9-api.version" -}}
{{- default .Chart.AppVersion (default .Values.image.tag .Values.image.digest) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "n9-api.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "n9-api.labels" -}}
{{ include "n9-api.selectorLabels" . }}
app.kubernetes.io/version: {{ include "n9-api.version" . | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ include "n9-api.chart" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "n9-api.selectorLabels" -}}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/name: {{ include "n9-api.name" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "n9-api.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "n9-api.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the cluster role to use
*/}}
{{- define "n9-api.clusterRoleName" -}}
{{- if .Values.clusterRole.create }}
{{- if .Values.clusterRole.name }}
{{- (printf "%s-%s" .Values.clusterRole.name .Release.Namespace ) }}
{{- else }}
{{- (printf "%s-%s" (include "n9-api.fullname" .) .Release.Namespace )  }}
{{- end }}
{{- else }}
{{- default "default" .Values.clusterRole.name }}
{{- end }}
{{- end }}

{{/*
Expand the usage of the api.type for specific env values
*/}}
{{- define "n9-api.apiType-env-values" -}}
{{- if eq .Values.api.type "node" -}}
- name: NODE_ENV
  value: {{ (include "n9-api.deployedEnv" .) | quote }}
{{- else if eq .Values.api.type "java" -}}
- name: PROFILE
  value: {{ (include "n9-api.deployedEnv" .) | quote }}
{{- else -}}
- name: {{ .Values.api.type | upper }}
  value: {{ (include "n9-api.deployedEnv" .) | quote }}
{{- end }}
{{- end }}

{{/*
Expand the usage of the api.type for specific healtcheck path
*/}}
{{- define "n9-api.apiType-healthCheck-path" -}}
{{- if eq .Values.api.type "node" -}}
{{- "/ping" }}
{{- else if eq .Values.api.type "java" -}}
{{- "/actuator/health" }}
{{- end }}
{{- end }}

{{/*
Expand the usage of the api.type for specific metrics port
*/}}
{{- define "n9-api.apiType-metrics-port" -}}
{{- if eq .Values.api.type "node" -}}
{{- "9101" }}
{{- else if eq .Values.api.type "java" -}}
{{- "8080" }}
{{- end }}
{{- end }}