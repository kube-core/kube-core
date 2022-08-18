# kps

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.56.3](https://img.shields.io/badge/AppVersion-0.56.3-informational?style=flat-square)

Neo9 monitoring stack (kps+thanos+minio+robusta)

## Requirements

Kubernetes: `>=1.16.0-0`

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami/ | kps-thanos(thanos) | 10.5.0 |
| https://helm.min.io/ | kps-minio(minio) | 8.0.10 |
| https://prometheus-community.github.io/helm-charts | kps(kube-prometheus-stack) | 35.5.1 |
| https://robusta-charts.storage.googleapis.com | kps-robusta(robusta) | 0.9.12 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| kps.enabled | bool | `true` |  |
| kps.kubeDns.enabled | bool | `true` |  |
| kps.coreDns.enabled | bool | `false` |  |
| kps.kubeProxy.enabled | bool | `false` |  |
| kps.kubeScheduler.enabled | bool | `false` |  |
| kps.kubeControllerManager.enabled | bool | `false` |  |
| kps.kubeEtcd.enabled | bool | `false` |  |
| kps.defaultRules.rules.kubeScheduler | bool | `false` |  |
| kps.defaultRules.rules.kubeProxy | bool | `false` |  |
| kps.prometheus.prometheusSpec.externalLabels.cluster | string | `"cluster-name"` |  |
| kps.prometheus.prometheusSpec.ruleSelectorNilUsesHelmValues | bool | `false` |  |
| kps.prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues | bool | `false` |  |
| kps.prometheus.prometheusSpec.podMonitorSelectorNilUsesHelmValues | bool | `false` |  |
| kps.prometheus.prometheusSpec.probeSelectorNilUsesHelmValues | bool | `false` |  |
| kps.prometheus.prometheusSpec.retention | string | `"72h"` |  |
| kps.prometheus.prometheusSpec.thanos.image | string | `"quay.io/thanos/thanos:v0.26.0"` |  |
| kps.prometheus.prometheusSpec.thanos.version | string | `"v0.26.0"` |  |
| kps.prometheus.prometheusSpec.thanos.objectStorageConfig.name | string | `"kps-thanos-objstore-secret"` |  |
| kps.prometheus.prometheusSpec.thanos.objectStorageConfig.key | string | `"objstore.yml"` |  |
| kps.prometheus.thanosService.enabled | bool | `true` |  |
| kps.prometheus.additionalServiceMonitors[0].name | string | `"thanos"` |  |
| kps.prometheus.additionalServiceMonitors[0].endpoints[0].interval | string | `"10s"` |  |
| kps.prometheus.additionalServiceMonitors[0].endpoints[0].port | string | `"http"` |  |
| kps.prometheus.additionalServiceMonitors[0].jobLabel | string | `"thanos"` |  |
| kps.prometheus.additionalServiceMonitors[0].namespaceSelector.matchNames[0] | string | `"monitoring"` |  |
| kps.prometheus.additionalServiceMonitors[0].selector.matchLabels."app.kubernetes.io/name" | string | `"kps-thanos"` |  |
| kps.prometheus.ingress.enabled | bool | `false` |  |
| kps.prometheus.ingress.annotations | object | `{}` |  |
| kps.prometheus.ingress.labels | object | `{}` |  |
| kps.prometheus.ingress.tls | list | `[]` |  |
| kps.prometheus.ingress.hosts | list | `[]` |  |
| kps.grafana.replicas | int | `1` |  |
| kps.grafana.adminPassword | string | `"admin"` |  |
| kps.grafana.defaultDashboardsTimezone | string | `"Europe/Paris"` |  |
| kps.grafana.sidecar.datasources.uid | string | `"thanos"` |  |
| kps.grafana.sidecar.dashboards.provider.folder | string | `"Kps"` |  |
| kps.grafana.plugins[0] | string | `"grafana-piechart-panel"` |  |
| kps.grafana.plugins[1] | string | `"flant-statusmap-panel"` |  |
| kps.grafana.datasources."datasources.yaml".apiVersion | int | `1` |  |
| kps.grafana.datasources."datasources.yaml".deleteDatasources[0].name | string | `"Prometheus"` |  |
| kps.grafana.datasources."datasources.yaml".deleteDatasources[0].orgId | int | `1` |  |
| kps.grafana.datasources."datasources.yaml".deleteDatasources[1].name | string | `"Thanos"` |  |
| kps.grafana.datasources."datasources.yaml".deleteDatasources[1].orgId | int | `1` |  |
| kps.grafana.datasources."datasources.yaml".datasources[0].name | string | `"Thanos"` |  |
| kps.grafana.datasources."datasources.yaml".datasources[0].type | string | `"prometheus"` |  |
| kps.grafana.datasources."datasources.yaml".datasources[0].url | string | `"http://kps-thanos-query.monitoring.svc:9090"` |  |
| kps.grafana.datasources."datasources.yaml".datasources[0].access | string | `"proxy"` |  |
| kps.grafana.datasources."datasources.yaml".datasources[0].editable | bool | `false` |  |
| kps.grafana.ingress.enabled | bool | `false` |  |
| kps.grafana.ingress.annotations | object | `{}` |  |
| kps.grafana.ingress.labels | object | `{}` |  |
| kps.grafana.ingress.tls | list | `[]` |  |
| kps.grafana.ingress.hosts | list | `[]` |  |
| kps.grafana.dashboardProviders | object | `{}` |  |
| kps.grafana.dashboards | object | `{}` |  |
| kps.alertmanager.ingress.enabled | bool | `false` |  |
| kps.alertmanager.ingress.annotations | object | `{}` |  |
| kps.alertmanager.ingress.labels | object | `{}` |  |
| kps.alertmanager.ingress.tls | list | `[]` |  |
| kps.alertmanager.ingress.hosts | list | `[]` |  |
| kps.alertmanager.config | object | `{}` |  |
| kps-thanos.enabled | bool | `true` |  |
| kps-thanos.fullnameOverride | string | `"kps-thanos"` |  |
| kps-thanos.objstoreConfig | string | `"type: s3\nconfig:\n  bucket: kps-thanos\n  endpoint: kps-minio.monitoring.svc.cluster.local:9000\n  access_key: minio\n  secret_key: minio123\n  insecure: true"` |  |
| kps-thanos.bucketweb.enabled | bool | `true` |  |
| kps-thanos.compactor.enabled | bool | `true` |  |
| kps-thanos.compactor.retentionResolutionRaw | string | `"15d"` |  |
| kps-thanos.compactor.retentionResolution5m | string | `"30d"` |  |
| kps-thanos.compactor.retentionResolution1h | string | `"180d"` |  |
| kps-thanos.compactor.persistence.size | string | `"20Gi"` |  |
| kps-thanos.storegateway.enabled | bool | `true` |  |
| kps-thanos.ruler.enabled | bool | `false` |  |
| kps-thanos.query.enabled | bool | `true` |  |
| kps-thanos.query.dnsDiscovery.sidecarsService | string | `"kps-thanos-discovery"` |  |
| kps-thanos.query.dnsDiscovery.sidecarsNamespace | string | `"monitoring"` |  |
| kps-thanos.query.replicaLabel[0] | string | `"prometheus_replica"` |  |
| kps-thanos.metrics.enabled | bool | `true` |  |
| kps-thanos.metrics.serviceMonitor.enabled | bool | `true` |  |
| kps-minio.enabled | bool | `true` |  |
| kps-minio.resources.requests.memory | string | `"1Gi"` |  |
| kps-minio.fullnameOverride | string | `"kps-minio"` |  |
| kps-minio.accessKey | string | `"minio"` |  |
| kps-minio.secretKey | string | `"minio123"` |  |
| kps-minio.defaultBucket.enabled | bool | `true` |  |
| kps-minio.defaultBucket.name | string | `"kps-thanos"` |  |
| kps-minio.defaultBucket.policy | string | `"none"` |  |
| kps-minio.defaultBucket.purge | bool | `false` |  |
| kps-minio.buckets | list | `[]` |  |
| kps-robusta.enabled | bool | `false` |  |
| kps-robusta.enablePrometheusStack | bool | `false` |  |
| kps-robusta.enableServiceMonitors | bool | `false` |  |
| kps-robusta.disableCloudRouting | bool | `true` |  |
| kps-robusta.enablePlatformPlaybooks | bool | `false` |  |
| kps-robusta.clusterName | string | `"neo9-default"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.8.1](https://github.com/norwoodj/helm-docs/releases/v1.8.1)
