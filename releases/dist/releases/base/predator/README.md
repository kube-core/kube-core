# Predator Helm Chart

         
[Predator](https://predator.dev) is an [open-source](https://github.com/Zooz/predator) distributed performance testing platform for APIs.
                                    
Predator manages the entire lifecycle of stress-testing servers, from creating performance tests, to running these tests on a scheduled and on-demand basis, and finally viewing the test results in a highly informative and live report.

It has a simple, one-click installation, built with support for Kubernetes, DC/OS and Docker Engine, and can persist the created performance tests and their reports in 5 different databases. It also supports running distributed load out of the box. Bootstrapped with a user-friendly UI alongside a simple REST API, Predator helps developers simplify the performance testing regime.

## TL;DR;

```console
$ helm install my-release zooz/predator
```

The command deploys predator on the Kubernetes cluster with the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the my-release deployment:

```console
$ helm uninstall my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

By default configuration, `Predator` runs with sqlite as its storage without persistence.
It is possible to run with persistence with the following configuration:

`Predator` with SQLite persisted storage 
```console
$ helm install my-release zooz/predator --set persistence.enabled=true
```

`Predator` supports other storage engines like Cassandra, postgresSQL, MySql and SQL Server.
If you want to use any of this database just install with these configuration:

```console
$ helm install my-release zooz/predator --set database.type=MYSQL,database.name=predator,database.address=mysql.default,database.password=cHJlZGF0b3I=,database.password=cHJlZGF0b3I=
```
> **Note**:
>
> database.username & database.password should be provided in base 64
>

The following tables lists the configurable parameters of the Predator chart, and their default values.


| Parameter                                     | Description                                                      | Default                                      |
| ------------------------------------          | ---------------------------------------------------------------- | -------------------------------------------- |
| `image.repository`                            | container image                                                  | `zooz/predator`                              |
| `image.tag`                                   | container image tag                                              | `1.6`                                        |
| `image.pullPolicy`                            | Operator container image pull policy                             | `Always`                                     |
| `nameOverride`                                | Override the app name                                            |                                              |
| `fullnameOverride`                            | Override the app full name                                       |                                              |
| `resources`                                   | Set the resource to be allocated and allowed for the Pods        | `{}`                                         |
| `ingress.enabled`                             | If true, an ingress is be created                                | `false`
| `ingress.annotations`                         | Annotations for the ingress                                      | `{}`
| `ingress.path`                                | Path for backend                                                 | `/`
| `ingress.hosts`                               | A list of hosts for the ingresss                                 | `['predator.local']`
| `ingress.tls`                                 | Ingress TLS configuration                                        | `[]`
| `nodeSelector`                                | Node labels for pod assignment                                   | `{}`                                         |
| `tolerations`                                 | Tolerations for pod assignment                                   | `[]`                                         |
| `affinity`                                    | Affinity settings for pod assignment                             | `{}`                                         |
| `service.type`                                | type of controller service to create                             | `ClusterIP`
| `database.type`                               | chosen storage backend, Optional Values: SQLITE, CASSANDRA, MYSQL, POSTGRES AND SQLSERVER | `SQLITE`
| `datbase.name`                                | the name of the database/keyspace with the selected database type|
| `database.username`                           | Database username (in base64)                                    |                                              |
| `database.password`                           | Database password (in base64)                                    |                                              |
| `kubernetesUrl    `                           | URL of kubernetes, Predator should be able to communicate with this url. | https://kubernetes.default.svc       |
| `persistence.enabled`                         | Use persistent volume to store data                               | `false`                                     |
| `persistence.size`                            | Size of persistent volume claim                                     | `2Gi`                                      |
| `persistence.existingClaim`                   | Use an existing PVC to persist data                                 | `nil`                                       |
| `persistence.storageClassName`                | Name of StorageClass resource                                     | `nil`                                       |
| `persistence.accessModes`                     | Persistence access modes                                            | `[ReadWriteOnce]`                           |
| `podAnnotations`                              | annotations for pod                                                           | {}                                   |
| `image.pullSecrets`                           | specifies that Kubernetes should get the credentials from a Secret  | `[]`                     |
| `port`                                        | Port where service is exposed   | 80                                      |
| `delayRunnerMs`                               | delay runner test start, useful when sidecars are used   | 0                                      |
| `runnerDockerImage`                           | The predator-runner docker image that will run the test   | zooz/predator-runner:1.6                                      |
| `runnerCpu`                                   | How much CPU require for predator-runner   | 1                                      |
| `runnerMemory`                                | How much memory require for predator-runner  | 256                                      |
| `intervalCleanupFinishedContainers`           | search and delete finished tests containers interval (ms)   | 0                                      |
| `customRunnerDefinition`                      | custom json that will be merged with the kubernetes predator runner job definition   | `nil`              |
| `allowInsecureTls`                            | If true, don't fail requests on unverified server certificate errors   | true                                      |
| `skipInternalAddressCheck`                    | If false, Predator will test the INTERNAL_ADDRESS  on startup                         | `true`                           |
| `serviceAccount.create`                       | If true, create service account  | true                                               |
| `serviceAccount.name`                         | Override the service account name  | `nil`                                            |
| `streaming.platform`                          | Type of platform to produce messages to (KAFKA)                                       |                             |
| `streaming.platformHealthCheckTimeoutMs`      | Health check timeout to streaming platform	                                        | 2000                         |
| `streaming.excludedAttributes`	            | Attribute names to exclude from being produced in the resource to streaming platform	|                         |
| `streaming.kafka.brokers`                     | String list of kafka brokers, split by ',' delimiter	                                |                          |
| `streaming.kafka.clientId`                    | Id of kafka client	                                                                | predator                         |
| `streaming.kafka.topic`                       | Topic name	                                                                        |                          |
| `streaming.kafka.autoTopicCreation`           | Enable kafka client to auto create topic if it does not exist	                        | false                         |
| `streaming.kafka.adminRetries`                | Admin client retries	                                                                | 2                         |
