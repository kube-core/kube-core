# n9-api

![Version: 1.3.0](https://img.shields.io/badge/Version-1.3.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: latest](https://img.shields.io/badge/AppVersion-latest-informational?style=flat-square)

Neo9 standard API chart

## Requirements

Kubernetes: `>= 1.12.0-0 <= 1.24.x-x`

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| "If.api.type=java".pod.env.valuesMap.PROFILE | string | `".deployedEnv"` | If not set release namespace is the default value |
| "If.api.type=java".service.labels.spring-boot | string | `"true"` | Always injected for apiType=java |
| "If.api.type=java".healtcheck.path | string | `"/actuator/health"` | Overrided by chart values if set |
| "If.api.type=java".metrics.port | int | `8080` | Overrided by chart values if set |
| "If.api.type=node".pod.env.valuesMap.NODE_ENV | string | `".deployedEnv"` | If not set release namespace is the default value |
| "If.api.type=node".healtcheck.path | string | `"/ping"` | Overrided by chart values if set |
| "If.api.type=node".metrics.port | int | `9101` | Overrided by chart values if set |
| name.appNameOverride | string | `""` | Override to set 'application name' if different from the release name (or template: namespace-release-name) |
| name.templatedNameOverride | string | `""` | Override the 'application name' to be used as a convention to name k8s ressources create by chart |
| api.type | string | `"node"` | Only "node" or "java" will set multiple default value in releases, check readme |
| api.deployedEnv | string | `""` | Override the release namespace value for env var sent to pod |
| api.logLevel | string | `""` | No default values, check https://github.com/neo9/n9-node-log |
| image.repository | string | `"n9/api"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.pullSecrets | list | `[]` |  |
| image.tag | string | `"latest"` | Define the image tag which by default is 'latest' |
| image.digest | string | `""` | Overrides tag if set |
| istio.enabled | bool | `false` | Create virtual service ressource (v1alpha3) |
| istio.retries | object | `{}` |  |
| global.deployedEnv | string | `""` | Not recommended by default, designed to expose 'api.deployedEnv' into parent-chart (subchart values override global values) |
| global.logLevel | string | `""` | Not recommended by default, designed to expose 'api.logLevel' into parent-chart (subchart values override global values) |
| global.imagePullSecrets | list | `[]` | Not recommended by default, designed to expose 'image.pullSecrets' into parent-chart (subchart values override global values) |
| global.istio.enabled | string | `""` | Not recommended by default, designed to expose 'istio.enabled' into parent-chart (subchart values override global values) |
| service.type | string | `"ClusterIP"` |  |
| service.port | int | `80` |  |
| service.targetPort | string | `""` | Port to access on the pod if different from port used by service |
| service.labels | object | `{}` |  |
| service.annotations | object | `{}` |  |
| service.additionalPorts | list | `[]` | Create additional pods endpoints and relative service |
| ingress.enabled | bool | `false` |  |
| ingress.className | string | `""` |  |
| ingress.defaultPathType | string | `"ImplementationSpecific"` | Set a default pathType for all hosts |
| ingress.globalEasyTls | bool | `false` | Automatically generate tls certificate secret for defined hosts |
| ingress.labels | object | `{}` |  |
| ingress.annotations | object | `{}` |  |
| ingress.hosts | list | `[]` |  |
| ingress.additionalHosts | list | `[]` |  |
| ingress.tls | list | `[]` |  |
| resources | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| autoscaling.targetMemoryUtilizationPercentage | int | `80` |  |
| scheduling.nodeSelector | object | `{}` |  |
| scheduling.tolerations | list | `[]` |  |
| scheduling.affinity | object | `{}` |  |
| metrics.enabled | bool | `false` | Condition to enable ports and service for metrics endpoints |
| metrics.port | string | `""` |  |
| metrics.serviceMonitor.enabled | bool | `false` |  |
| metrics.serviceMonitor.interval | string | `"15s"` | Value in seconds suffixed by unit 's' |
| deployment.labels | object | `{}` |  |
| deployment.annotations."reloader.stakater.com/auto" | string | `"true"` |  |
| deployment.progressDeadlineSeconds | string | `""` |  |
| deployment.minReadySeconds | string | `""` |  |
| deployment.replicaCount | int | `1` | Automatically create podDisruptionBudget if more than 1 replica |
| deployment.minAvailable | int | `1` | Default to 1 if not set for the podDisruptionBudget |
| deployment.strategy | object | `{}` | Default Rolling Update |
| deployment.securityContext | object | `{}` |  |
| pod.workingDir | string | `""` |  |
| pod.command | list | `[]` |  |
| pod.args | list | `[]` |  |
| pod.annotations | object | `{}` |  |
| pod.securityContext | object | `{}` |  |
| pod.env.values | list | `[]` | Define env values for pods, example commented out in values.yaml files |
| pod.env.secrets | list | `[]` | Define secret env values for pods, example commented out in values.yaml files |
| pod.env.valuesMap | object | `{}` | Define and sent env Values as a map, useful for yaml merge |
| pod.additionalEnv.values | list | `[]` |  |
| pod.additionalEnv.secrets | list | `[]` |  |
| pod.additionalEnv.valuesMap | object | `{}` |  |
| pod.mounts.configMap | list | `[]` | Define configmap to attach and mount, example commented out in values.yaml files |
| pod.mounts.secrets | list | `[]` | Define secrets to attach and mount, example commented out in values.yaml files |
| pod.mounts.configMapMap | object | `{}` | Define map of configmap to mount, useful for yaml merge |
| pod.mounts.pvc | list | `[]` | Define pvc to attach and mount, example commented out in values.yaml files |
| configMap | list | `[]` | Generate and define content of one or multiple configmap |
| pdb.enabled | bool | `false` | Create Pod Disruption Budget |
| pdb.minAvailable | int | `1` |  |
| hpa.enabled | bool | `false` | Create Horizontal Pod Autoscaling |
| hpa.customMetrics | list | `[]` |  |
| hpa.minReplicas | int | `1` |  |
| hpa.maxReplicas | int | `5` |  |
| hpa.cpu | int | `100` |  |
| hpa.memory | int | `80` |  |
| hpa.rabbitmq.enabled | bool | `false` |  |
| hpa.rabbitmq.serviceName | string | `"rabbitmq"` |  |
| hpa.rabbitmq.metricName | string | `"master-api_queue_messages"` |  |
| hpa.rabbitmq.target | int | `1` |  |
| healthCheck.enabled | bool | `true` |  |
| healthCheck.tcpSocket | bool | `false` | Enabled usage of tcpSocket probe over httpget probe |
| healthCheck.port | string | `""` | Specify port to probe if different from service port |
| healthCheck.path | string | `""` | Specify a port for httpGet probe, if different from /ping for node or /actuator/health for java |
| healthCheck.initialDelaySeconds | int | `3` |  |
| healthCheck.periodSeconds | int | `10` |  |
| healthCheck.timeoutSeconds | int | `1` |  |
| healthCheck.failureThreshold | int | `3` |  |
| healthCheck.liveness.enabled | bool | `true` |  |
| healthCheck.readiness.enabled | bool | `true` |  |
| serviceAccount.create | bool | `false` | Specifies whether a service account should be created |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.name | string | `""` | Name of service account to create or to use if not created by chart |
| clusterRole.create | bool | `false` | Specifies whether a cluster role should be created, also require to set rules. |
| clusterRole.name | string | `""` | Name of cluster role to create or to use if not created by chart |
| clusterRole.autoBindClusteRole | bool | `false` | Bind cluster role to service account created/named in chart values |
| clusterRole.rules | object | `{}` | Set clusterRole rules, example commented out in values.yaml files |
| initJob.enabled | bool | `false` |  |
| initJob.priorityClassName | string | `""` |  |
| initJob.command | list | `[]` |  |
| initJob.hookDeletionPolicy | string | `"before-hook-creation,hook-succeeded"` | Helm hook deletion policy on when to delete previous initjob |
| initJob.ttlSecondsAfterFinished | int | `300` |  |
| initJob.activeDeadlineSeconds | int | `950` |  |
| initJob.resources | object | `{}` | Example commented out in values.yaml files |
| initContainer.enabled | bool | `false` |  |
| initContainer.command[0] | string | `"env"` |  |
| initContainer.resources | object | `{}` |  |
| flux.enabled | bool | `false` |  |
| flux.imageRepository.interval | string | `"1m0s"` |  |
| flux.imageRepository.secretName | string | `"docker-registry-gcr-admin"` |  |
| flux.imageUpdateAutomation.enabled | bool | `false` |  |
| flux.imageUpdateAutomation.interval | string | `"1m0s"` |  |
| flux.imageUpdateAutomation.git.sourceRef | string | `"my-repo"` |  |
| flux.imageUpdateAutomation.git.ref.branch | string | `"main"` |  |
| flux.imageUpdateAutomation.git.pushRef.branch | string | `"main"` |  |
| flux.imageUpdateAutomation.git.author.email | string | `"flux-bot@my-domain.com"` |  |
| flux.imageUpdateAutomation.git.author.name | string | `"flux-bot"` |  |
| flux.imageUpdateAutomation.git.message | string | `"chore: Updating images"` |  |
| flux.imageUpdateAutomation.update.path | string | `"./config"` |  |
| flux.imageUpdateAutomation.update.strategy | string | `"Setters"` |  |
| flux.defaultImagePolicy | string | `"default"` |  |
| flux.defaultImagePoliciesEnabled | bool | `true` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.8.1](https://github.com/norwoodj/helm-docs/releases/v1.8.1)
