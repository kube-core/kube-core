{{- define "app-extensions.eck-elasticsearch" -}}
{{- $name := (coalesce .value.name .key) }}
{{- $resourceName := (coalesce .value.resourceName .value.name .key) }}
{{- $namespace := (coalesce .value.namespace "default") }}
apiVersion: elasticsearch.k8s.elastic.co/v1
kind: Elasticsearch
metadata:
  name: {{ $resourceName }}
spec:
  selector:
    matchLabels:
      common.k8s.elastic.co/type: elasticsearch
      elasticsearch.k8s.elastic.co/cluster-name: logging
      elasticsearch.k8s.elastic.co/statefulset-name: logging-es-default
  volumeClaimDeletePolicy: DeleteOnScaledownOnly
  http:
    tls:
      selfSignedCertificate:
        disabled: true
  version: {{ coalesce .value.esStackVersion "8.3.3" }}
  nodeSets:
  - name: default
    count: {{ coalesce .value.replicas }}
    podTemplate:
      spec:
        containers:
        - name: elasticsearch
          {{ if .value.resources }}
          resources: {{ toYaml .value.resources | nindent 12 }}
          {{ end }}
          env:
          - name: ES_JAVA_OPTS
            value: {{ toYaml .value.esJavaOpts }}
        initContainers:
        - name: sysctl
          securityContext:
            privileged: true
          command: ['sh', '-c', 'sysctl -w vm.max_map_count=262144']
        - name: increase-ulimit
          image: busybox
          command: ['sh', '-c', 'ulimit -n 65536']
          securityContext:
            privileged: true
    volumeClaimTemplates:
    - metadata:
        name: elasticsearch-data # Do not change this name unless you set up a volume mount for the data path.
      spec:
        accessModes:
        - ReadWriteOnce
        resources:
          requests:
            storage: {{ .value.storageSize }}
        storageClassName: {{ .value.storageClassName }}
    config:
      node.roles: ["master", "data", "ingest"]
      node.store.allow_mmap: false
      # xpack.security.enabled: false
      xpack.security.authc:
        anonymous:
          username: anonymous
          roles: superuser
          authz_exception: false
{{ end }}
