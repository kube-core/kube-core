# Nexus

[Nexus OSS](https://www.sonatype.com/nexus-repository-oss) is a free open source repository manager. It supports a wide range of package formats and it's used by hundreds of tech companies.

## Introduction

This chart bootstraps a Nexus OSS deployment on a cluster using Helm.
This setup is best configured in [GCP](https://cloud.google.com/) since:

- [google cloud storage](https://cloud.google.com/storage/) is used for backups
- [NEW: Rclone](https://rclone.org/) it uses Rclone to create backups, basically compatible with all the major clouds.
- [GCE Ingress controller](https://github.com/kubernetes/ingress/blob/master/docs/faq/gce.md) is used for using a pre-allocated static IP in GCE.

There is also the option of using a [proxy for Nexus](https://github.com/travelaudience/nexus-proxy) that authenticates Nexus against an external identity provider (only GCP IAM at the moment) which is **disabled** by default.

## Prerequisites

- Kubernetes 1.15+ with Beta APIs enabled
- PV provisioner support in the underlying infrastructure
- [Fulfill Nexus kubernetes requirements](https://github.com/travelaudience/kubernetes-nexus#pre-requisites)

### With GCP IAM enabled

All the [Prerequisites](#Prerequisites) should be in place, plus:

- [Fulfill GCP IAM requirements](https://github.com/travelaudience/kubernetes-nexus/blob/master/docs/admin/configuring-nexus-proxy.md#pre-requisites)

## Testing the Chart

To test the chart:

```bash
helm install --dry-run --debug ./
```

To test the chart with your own values:

```bash
helm install --dry-run --debug -f my_values.yaml ./
```

## Installing the Chart

To install the chart:

```bash
helm repo add oteemocharts https://oteemo.github.io/charts
helm install sonatype-nexus oteemocharts/sonatype-nexus
```

The above command deploys Nexus on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

The default login is admin/admin123

## Uninstalling the Chart

To uninstall/delete the deployment:

```bash
$ helm list
NAME           REVISION   UPDATED                   STATUS    CHART                 NAMESPACE
plinking-gopher 1         Fri Sep  1 13:19:50 2017  DEPLOYED  sonatype-nexus-0.1.0 default
$ helm delete plinking-gopher
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Official Nexus image vs TravelAudience

There are known issues with backups on the official image. If you want to swap in the official image, just override the values when installing the chart. Please note that backups will not work as expected with the official image.

- [https://issues.sonatype.org/browse/NEXUS-23442](https://issues.sonatype.org/browse/NEXUS-23442)
- [https://github.com/travelaudience/docker-nexus](https://github.com/travelaudience/docker-nexus)

## Configuration

The following table lists the configurable parameters of the Nexus chart and their default values.

| Parameter                                                     | Description                         | Default                                 |
| ------------------------------------------------------------  | ----------------------------------  | ----------------------------------------|
| `namespaceOverride`                                           | Override for namespace              | `nil` |
| `statefulset.enabled`                                         | Use statefulset instead of deployment | `false` |
| `replicaCount`                                                | Number of Nexus service replicas    | `1`                                     |
| `deploymentStrategy`                                          | Deployment Strategy     |  `rollingUpdate` |
| `initAdminPassword.enabled`                 | Enable initialization of admin password on Helm install | `false`    |
| `initAdminPassword.defaultPasswordOverride` | Override the default admin password                     | `nil`      |
| `initAdminPassword.password`                | Admin password to be set                                | `admin321` |
| `nexus.imageName`                           | Nexus image                         | `quay.io/travelaudience/docker-nexus`   |
| `nexus.imageTag`                            | Version of Nexus                    | `3.25.1`                                 |
| `nexus.imagePullPolicy`                     | Nexus image pull policy             | `IfNotPresent`                          |
| `nexus.imagePullSecret`                     | Secret to download Nexus image from private registry      | `nil`             |
| `nexus.env`                                 | Nexus environment variables         | `[{install4jAddVmParams: -Xms1200M -Xmx1200M -XX:MaxDirectMemorySize=2G -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap}]` |
| `nexus.resources`                           | Nexus resource requests and limits  | `{}`                                    |
| `nexus.dockerPort`                          | Port to access docker               | `5003`                                  |
| `nexus.nexusPort`                           | Internal port for Nexus service     | `8081`                                  |
| `nexus.additionalPorts`                     | expose additional ports             | `[]`                                  |
| `nexus.service.type`                        | Service for Nexus                   | `NodePort`                                |
| `nexus.service.clusterIp`                   | Specific cluster IP when service type is cluster IP. Use None for headless service |`nil`   |
| `nexus.service.loadBalancerIP`                        | Custom loadBalancerIP                   |`nil`                                |
| `nexus.securityContextEnabled`                     | Security Context (for enabling official image use `fsGroup: 200`) | `{}`     |
| `nexus.labels`                              | Service labels                      | `{}`                                    |
| `nexus.podAnnotations`                      | Pod Annotations                     | `{}`
| `nexus.livenessProbe.initialDelaySeconds`   | LivenessProbe initial delay         | 30                                      |
| `nexus.livenessProbe.periodSeconds`         | Seconds between polls               | 30                                      |
| `nexus.livenessProbe.failureThreshold`      | Number of attempts before failure   | 6                                       |
| `nexus.livenessProbe.timeoutSeconds`        | Time in seconds after liveness probe times out    | `nil`                     |
| `nexus.livenessProbe.path`                  | Path for LivenessProbe              | /                                       |
| `nexus.readinessProbe.initialDelaySeconds`  | ReadinessProbe initial delay        | 30                                      |
| `nexus.readinessProbe.periodSeconds`        | Seconds between polls               | 30                                      |
| `nexus.readinessProbe.failureThreshold`     | Number of attempts before failure   | 6                                       |
| `nexus.readinessProbe.timeoutSeconds`       | Time in seconds after readiness probe times out    | `nil`                    |
| `nexus.readinessProbe.path`                 | Path for ReadinessProbe             | /                                       |
| `nexus.startupProbe.initialDelaySeconds`    | StartupProbe initial delay          | 30                                      |
| `nexus.startupProbe.periodSeconds`          | Seconds between polls               | 30                                      |
| `nexus.startupProbe.failureThreshold`       | Number of attempts before failure   | 6                                       |
| `nexus.startupProbe.timeoutSeconds`         | Time in seconds after startup probe times out    | `nil`                     |
| `nexus.startupProbe.path`                   | Path for StartupProbe              | /                                       |
| `nexus.hostAliases`                         | Aliases for IPs in /etc/hosts       | []                                      |
| `nexus.context`                             | Non-root path to run Nexus at       | `nil`                                   |
| `nexus.chownNexusData`                      | Set false to not execute chown to the mounted nexus-data directory at startup | `true` |
| `nexus.terminationGracePeriodSeconds`       | Let Nexus terminate gracefully [More informations here](#graceful-shutdown-with-terminationGracePeriodSeconds).     | `nil`                                   |
| `nexusProxy.enabled`                        | Enable nexus proxy                  | `true`                                  |
| `nexusProxy.svcName`                        | Nexus proxy service name            | `nil`                                  |
| `nexusProxy.targetPort`                     | Container Port for Nexus proxy      | `8080`                                  |
| `nexusProxy.port`                           | Port for exposing Nexus             | `8080`                                  |
| `nexusProxy.imageName`                      | Proxy image                         | `quay.io/travelaudience/docker-nexus-proxy` |
| `nexusProxy.imageTag`                       | Proxy image version                 | `2.6.0`                                 |
| `nexusProxy.imagePullPolicy`                | Proxy image pull policy             | `IfNotPresent`                          |
| `nexusProxy.resources`                      | Proxy resource requests and limits  | `{}`                                    |
| `nexusProxy.env.nexusHttpHost`              | Nexus url to access Nexus           | `nil`                                   |
| `nexusProxy.env.nexusDockerHost`            | Containers url to be used with docker | `nil`                                 |
| `nexusProxy.env.enforceHttps`               | Allow only https access or not      | `false`                                 |
| `nexusProxy.env.cloudIamAuthEnabled`        | Enable GCP IAM authentication in Nexus proxy  | `false`                       |
| `nexusProxyRoute.enabled`     | Set to true to create route for additional service | `false` |
| `nexusProxyRoute.labels`      | Labels to be added to proxy route            | `{}` |
| `nexusProxyRoute.annotations` | Annotations to be added to proxy route       | `{}` |
| `nexusProxyRoute.path`        | Host name of Route e.g jenkins.example.com   |  nil |
| `persistence.enabled`                       | Create a volume for storage         | `true`                                  |
| `persistence.accessMode`                    | ReadWriteOnce or ReadOnly           | `ReadWriteOnce`                         |
| `persistence.storageClass`                  | Storage class of Nexus PVC          | `nil`                                   |
| `persistence.storageSize`                   | Size of Nexus data volume           | `8Gi`                                   |
| `persistence.annotations`                   | Persistent Volume annotations       | `{}`                                    |
| `persistence.existingClaim`                 | Existing PVC name                   | `nil`                                   |
| `nexusBackup.enabled`                       | Nexus backup process                | `false`                                 |
| `nexusBackup.imageName`                     | Nexus backup image                  | `dbcc/docker-nexus-backup` |
| `nexusBackup.imageTag`                      | Nexus backup image version          | `0.0.1`                                 |
| `nexusBackup.imagePullPolicy`               | Backup image pull policy            | `IfNotPresent`                          |
| `nexusBackup.env.rcloneRemote`              | Required if `nexusBackup` is enabled. Name of the Rclone remote as defined in the `rcloneConfig` entry. Example: `AWS`  | `nil`  |
| `nexusBackup.env.targetBucket`              | Required if `nexusBackup` is enabled. Name of the target bucket or bucket/path. Example: `my_bucket` or `my_bucket/my_folder`  | `nil`  |
| `nexusBackup.env.streamingUploadCutoff`     | Size of the data chunks to send to the Rclone remote, this value affects the maximum size of the backup file to upload.  | `"5000000"`  |
| `nexusBackup.env.nexusAuthorization`        | If set, `nexusBackup.nexusAdminPassword` will be disregarded. | `nil`  |
| `nexusBackup.env.offlineRepos`              | Space separated list of repositories must be taken down to achieve a consistent backup. | `"maven-central maven-public maven-releases maven-snapshots"`  |
| `nexusBackup.env.gracePeriod`               | The amount of time in seconds to wait between stopping repositories and starting the upload. | `60`  |
| `nexusBackup.nexusAdminPassword`            | Nexus admin password used by the backup container to access Nexus API. This password should match the one that gets chosen by the user to replace the default admin password after the first login  | `admin123`                |
| `nexusBackup.persistence.enabled`           | Create a volume for backing Nexus configuration  | `true`                     |
| `nexusBackup.persistence.accessMode`        | ReadWriteOnce or ReadOnly           | `ReadWriteOnce`                         |
| `nexusBackup.persistence.storageClass`      | Storage class of Nexus backup PVC   | `nil`                                   |
| `nexusBackup.persistence.storageSize`       | Size of Nexus backup data volume    | `8Gi`                                   |
| `nexusBackup.persistence.annotations`       | PV annotations for backup           | `{}`                                    |
| `nexusBackup.persistence.existingClaim`     | Existing PVC name for backup        | `nil`                                   |
| `nexusBackup.resources`                     | Backup resource requests and limits | `{}`                                    |
| `nexusBackup.rcloneConfig.rclone.conf`                 | Rclone remote configuration, can be generated using the `rclone config` command, or using docker: `docker run -it --rm rclone/rclone config` | `[AWS]` <br> `type = s3` <br> `provider = AWS` <br> `env_auth = true` <br> `region = us-east-1` <br> `acl = authenticated-read` |
| `nexusCloudiam.enabled`                       | Nexus Cloud IAM service account key path                | `false`                                 |
| `nexusCloudiam.persistence.accessMode`        | ReadWriteOnce or ReadOnly           | `ReadWriteOnce`                         |
| `nexusCloudiam.persistence.annotations`       | PV annotations for Cloud IAM service account key path | `{}`                                    |
| `nexusCloudiam.persistence.enabled`           | Create a volume for Cloud IAM service account key path  | `true`                     |
| `nexusCloudiam.persistence.existingClaim`     | Existing PVC name for Cloud IAM service account key path        | `nil`                                   |
| `nexusCloudiam.persistence.storageClass`      | Storage class of Cloud IAM service account path PVC   | `nil`                                   |
| `nexusCloudiam.persistence.storageSize`       | Size of Cloud IAM service account path volume    | `8Gi`                                   |
| `ingress.enabled`                           | Create an ingress for Nexus         | `false`                                  |
| `ingress.annotations`                       | Annotations to enhance ingress configuration  | `{}`                          |
| `ingress.tls.enabled`                       | Enable TLS                          | `true`                                 |
| `ingress.tls.secretName`                    | Name of the secret storing TLS cert, `false` to use the Ingress' default certificate | `nexus-tls`                             |
| `ingress.tls.hosts`                    | Custom TLS hosts configuration | `{}`                             |
| `ingress.path`                              | Path for ingress rules. GCP users should set to `/*` | `/`                    |
| `ingressDocker.enabled`                           | Create an ingress for Docker registry         | `false`                                  |
| `ingressDocker.annotations`                       | Annotations to enhance docker ingress configuration  | `{}`                          |
| `ingressDocker.tls.enabled`                       | Enable TLS                          | `true`                                 |
| `ingressDocker.tls.secretName`                    | Name of the secret storing TLS cert, `false` to use the Ingress' default certificate | `nexus-tls`                             |
| `ingressDocker.tls.hosts`                    | Custom TLS hosts configuration | `{}`                             |
| `ingressDocker.path`                              | Path for docker ingress rules. GCP users should set to `/*` | `/`                    |
| `tolerations`                               | tolerations list                    | `[]`                                    |
| `config.enabled`                            | Enable configmap                    | `false`                                 |
| `config.mountPath`                          | Path to mount the config            | `/sonatype-nexus-conf`                  |
| `config.data`                               | Configmap data                      | `nil`                                   |
| `deployment.annotations`                    | Annotations to enhance deployment configuration  | `{}`                       |
| `deployment.initContainers`                 | Init containers to run before main containers  | `nil`                        |
| `deployment.postStart.command`              | Command to run after starting the nexus container  | `nil`                    |
| `deployment.additionalContainers`           | Add additional Container         | `nil`                                      |
| `deployment.additionalVolumes`              | Add additional Volumes           | `nil`                                      |
| `deployment.additionalVolumeMounts`         | Add additional Volume mounts     | `nil`                                      |
| `secret.enabled`                            | Enable secret                    | `false`                                    |
| `secret.mountPath`                          | Path to mount the secret         | `/etc/secret-volume`                       |
| `secret.readOnly`                           | Secret readonly state            | `true`                                     |
| `secret.data`                               | Secret data to add to secret. If nil then expects that a secret by name of `${.Values.nameOverride}-secret` or `${.Chart.Name}-secret` exists                      | `nil`                                      |
| `service.enabled`                           | Enable additional service        | `nil`                                      |
| `service.name`                              | Service name                     | `nil`                                      |
| `service.portName`                          | Service port name                | `nil`                                      |
| `service.labels`                            | Service labels                   | `nil`                                      |
| `service.annotations`                       | Service annotations              | `nil`                                      |
| `service.loadBalancerSourceRanges`          | Service LoadBalancer source IP whitelist | `nil`                              |
| `service.loadBalancerIP`                        | Custom loadBalancerIP                   |`nil`                                |
| `service.targetPort`                        | Service port                     | `nil`                                      |
| `service.port`                              | Port for exposing service        | `nil`                                      |
| `serviceAccount.create`                     | Automatically create a service account | `true`                               |
| `serviceAccount.name`                       | Service account to use           | `nil`  |
| `serviceAccount.annotations`                | Service account annotations  | `nil` |
| `rbac.create`                               | Creates a ClusterRoleBinding attached to the Service account. | `false` |
| `rbac.roleRef`                              | ClusterRoleBinding field `roleRef` content. See examples [here](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#rolebinding-example). | `nil` |
| `rbac.annotations`                          | ClusterRoleBinding annotations.  | `nil` |
| `route.enabled`         | Set to true to create route for additional service | `false` |
| `route.name`            | Name of route                                      | `docker` |
| `route.portName`        | Target port name of service                        | `docker` |
| `route.labels`          | Labels to be added to route                        | `{}` |
| `route.annotations`     | Annotations to be added to route                   | `{}` |
| `route.path`            | Host name of Route e.g jenkins.example.com         | nil |
| `additionalConfigMaps`  | List of ConfigMap data containing Name, Data and Labels | nil |

If `nexusProxy.env.cloudIamAuthEnabled` is set to `true` the following variables need to be configured

| Parameter                        | Description                        | Default                                              |
| -----------------------------    | ---------------------------------- | ---------------------------------------------------- |
| `nexusProxy.env.clientId`        | GCP OAuth client ID                | `nil`                                                |
| `nexusProxy.env.clientSecret`    | GCP OAuth client Secret            | `nil`                                                |
| `nexusProxy.env.organizationId`  | GCP organization ID                | `nil`                                                |
| `nexusProxy.env.redirectUrl`     | OAuth callback url. example `https://nexus.example.com/oauth/callback` | `nil`            |
| `nexusProxy.env.requiredMembershipVerification` | Whether users presenting valid JWT tokens must still be verified for membership within the GCP organization. | `true`    |
| `nexusProxy.secrets.keystore`    | base-64 encoded value of the keystore file needed for the proxy to sign user tokens. Example: cat keystore.jceks &#124; base64 | `nil`  |
| `nexusProxy.secrets.password`    | Password to the Java Keystore file | `nil`                                                |

```bash
helm install --set persistence.enabled=false my-release oteemocharts/sonatype-nexus
```

The above example turns off the persistence. Data will not be kept between restarts or deployments

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
helm install -f my-values.yaml sonatype-nexus oteemocharts/sonatype-nexus
```

### Persistence

By default a PersistentVolumeClaim is created and mounted into the `/nexus-data` directory. In order to disable this functionality
you can change the `values.yaml` to disable persistence which will use an `emptyDir` instead.

> *"An emptyDir volume is first created when a Pod is assigned to a Node, and exists as long as that Pod is running on that node. When a Pod is removed from a node for any reason, the data in the emptyDir is deleted forever."*

You must enable StatefulSet (`statefulset.enabled=true`) for true data persistence. If using Deployment approach, you can not recover data after restart or delete of helm chart. Statefulset will make sure that it picks up the same old volume which was used by the previous life of the nexus pod, helping you recover your data. When enabling statefulset, its required to enable the persistence.

### Recommended settings

As a minimum for running in production, the following settings are advised:

```yaml
nexusProxy:
  env:
    nexusDockerHost: container.example.com
    nexusHttpHost: nexus.example.com

nexusBackup:
  env:
    targetBucket: "gs://my-nexus-backup"
  persistence:
    storageClass: standard

ingress:
  enabled: true
  annotations:
    kubernetes.io/ingress.class: gce
    kubernetes.io/tls-acme: true

persistence:
  storageClass: standard
  storageSize: 1024Gi

resources:
  requests:
    cpu: 250m
    # Based on https://support.sonatype.com/hc/en-us/articles/115006448847#mem
    # and https://twitter.com/analytically/status/894592422382063616:
    #   Xms == Xmx
    #   Xmx <= 4G
    #   MaxDirectMemory >= 2G
    #   Xmx + MaxDirectMemory <= RAM * 2/3 (hence the request for 4800Mi)
    #   MaxRAMFraction=1 is not being set as it would allow the heap
    #     to use all the available memory.
    memory: 4800Mi
```

### Using GCP Storage for Backup

Irrespective of whether Nexus is deployed to Google's GKE, or to some other k8s installation, it is possible to configure the [nexus-backup](https://github.com/travelaudience/docker-nexus-backup) container to backup to GCP Cloud Storage.
This makes for a cost effective solution for backups.

To enable, add the following key to the values file:

```yaml
nexusCloudiam:
  enabled: true
```

You should also deploy Nexus as a stateful app, rather than a deployment.
That means also adding:
 
```yaml
statefulset:
  enabled: true
```

Deploying the chart now will result in a new PV and PVC within the pod that runs the containers.

Create a service account with privileges to upload to your GCP bucket, and creaet a key for this service account.
Download that service account key as a file, call it `service-account-key.json`.

This file now needs to be made available to the pod running in k8s, and should be called `/nexus-data/cloudiam/service-account-key.json`.
How this is done will depend upon the storage class used for the PV.

Confirm that the service account file is available to the pod, using:
 
    kubectl exec --stdin --tty \
        --container nexus-backup \
        sonatype-nexus-0 \
        -- find /nexus-data/cloudiam -type f

You might need to scale the deployment to zero and back up to pick up the changes:

    kubectl scale --replicas=0 statefulset.apps/sonatype-nexus
    kubectl scale --replicas=1 statefulset.apps/sonatype-nexus

### Graceful shutdown with terminationGracePeriodSeconds
Customizing terminationGracePeriodSeconds maybe helpful to prevent Orientdb corruption during stop/start actions(eg : upgrade).  
**WARNING** : It has no effect with the [default image of this chart](https://quay.io/repository/travelaudience/docker-nexus?tag=latest&tab=tags) because of this [issue](https://github.com/travelaudience/docker-nexus/issues/56)  
However it can be useful when you switch to the official image [here](https://hub.docker.com/r/sonatype/nexus3/tags?page=1&ordering=last_updated)


## After Installing the Chart

After installing the chart a couple of actions need still to be done in order to use nexus. Please follow the instructions below.

### Nexus Configuration

The following steps need to be executed in order to use Nexus:

- [Configure Nexus](https://github.com/travelaudience/kubernetes-nexus/blob/master/docs/admin/configuring-nexus.md)
- [Configure Backups](https://github.com/travelaudience/kubernetes-nexus/blob/master/docs/admin/configuring-nexus.md#configure-backup)

and if GCP IAM authentication is enabled, please also check:

- [Enable GCP IAM authentication in Nexus](https://github.com/travelaudience/kubernetes-nexus/blob/master/docs/admin/configuring-nexus-proxy.md#enable-gcp-iam-auth)

### Nexus Usage

To see how to use Nexus with different tools like Docker, Maven, Python, and so on please check:

- [Nexus Usage](https://github.com/travelaudience/kubernetes-nexus#usage)

### Disaster Recovery

In a disaster recovery scenario, the latest backup made by the nexus-backup container should be restored. In order to achieve this please follow the procedure described below:

- [Restore Backups](https://github.com/travelaudience/kubernetes-nexus#restore)
