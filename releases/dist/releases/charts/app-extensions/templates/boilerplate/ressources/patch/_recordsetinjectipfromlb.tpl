{{- define "app-extensions.patch-recordsetinjectipfromlb" -}}
{{- $name := (coalesce .value.name .key) }}
{{- $resourceName := (coalesce .value.resourceName .value.name .key) }}

apiVersion: redhatcop.redhat.io/v1alpha1
kind: Patch
metadata:
  name: {{ $name }}
spec:
  serviceAccountRef:
    name: {{ .common.patch.serviceAccountName }}
  patches:
    inject-ip-from-the-load-balancer:
      targetObjectRef:
        apiVersion: dns.gcp.upbound.io/v1beta1
        kind: RecordSet
        annotationSelector:
          matchLabels:
            crossplane.io/external-name: {{ coalesce .value.externalName $name }}
            release.app-extensions.gcp-dns/record-type: "A"
      patchTemplate: |
        spec:
          forProvider:
            rrdatas:
              - {{ "{{ (index . 1).spec.forProvider.address }}" }}
      patchType: application/merge-patch+json
      sourceObjectRefs:
        - apiVersion: compute.gcp.upbound.io/v1beta1
          kind: GlobalAddress
          name: {{ .value.patch.globalAddress }}
          namespace: {{ .common.release.namespace }}
{{- end }}
