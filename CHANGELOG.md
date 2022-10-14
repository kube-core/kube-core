### Changelog

All notable changes to this project will be documented in this file. Dates are displayed in UTC.

#### v0.5.5

- core/releases: Added dex & rework oauth2-proxy
- core/envs: Added new options to enable Oauth2 on ingress & to disable ingress access operator
- core/envs: Added possibility to generate dynamically secrets for each releases
- core/values: Homogenized values format to set ingressClass
- core/envs: Force quote on metadata values in release secrets

#### v0.5.4

> 13 October 2022

- releases/flux-repository: Updated values templates and release
- releases: Added flux-repository
- releases/crossplane-buckets: Updated version to v0.3.1
- releases/kyverno-policies: Set failurePolicy to Ignore by default & Rebuilt chart
- core/releases: Cleaned up releases definitions
- core/envs: Added core.globalHelmMetadataEnabled to force rendering Helm labels/annotations on manifests
- release: v0.5.4
- core/envs: Added secret for flux-repository in release-secrets
- core/values: Added condition to handle using raw as a service
- cli/scripts: Activated ytt overlays by default, with toggle via cluster-config
- core/templates: Improved kube-core chart and values layering over applications/services and added toggles
- core/values: Improved n9-api default values template
- cli/scripts: Moved overlays at the end of kube-core build
- cli/scripts: Improved logging on gitops_overlay
- cli/scripts: Added some extra cleanup after building kube-core charts
- cli/scripts: Fixed overlays applied on actual config instead of staging area
- core/templates: Improved support of applications and services with injectClusterLoggingLabel

#### v0.5.3

> 11 October 2022

- core/templates: Removed label injection on custom releases
- release: v0.5.3

#### v0.5.2

> 11 October 2022

- core/envs: Added integrations between Core, Applications and Services for mongodb-managed and rabbitmq-managed
- cli/scripts: Reimplemented ytt Overlays
- release: v0.5.2

#### v0.5.1

> 7 October 2022

- core/templates: Added release-labels template to easily inject global labels in any relase
- release: v0.5.1

#### v0.5.0

> 7 October 2022

- core/templates: Reworked templates to allow for environments, applications and services generation
- releases: Added node-problem-detector
- core/envs: Reworked core values to allow for environments, applications and services generation
- core/values: Reworked values templates to allow for environments, applications and services generation
- releases/n9-api: Updated to v1.3.2
- core: Reworked core helmfiles to allow for environments, applications and services generation
- release: v0.5.0
- cli/workspace: Updated open command documentation

#### v0.4.5

> 4 October 2022

- cli: Added workspace:open command
- release: v0.4.5

#### v0.4.4

> 3 October 2022

- releases: Rebuilt all releases
- releases/mongodb-operator: Removed local chart and migrated to official one
- releases/cluster-policies: Disabeled fail safe mode by default & Updated some policies
- releases/rabbitmq-operator: Removed hooks and improved resource naming
- release: v0.4.4
- releases/logging-stack: Changed fluentd minReplicaCount to 3

#### v0.4.3

> 30 September 2022

- releases/cluster-policies: Disabled all mutations by default
- release: v0.4.3

#### v0.4.2

> 30 September 2022

- releases/cluster-policies: Reworked default configuration
- release: v0.4.2
- core/releases: Removed ingress upgrade options for tekton

#### v0.4.1

> 29 September 2022

- releases/tekton: Updated Ingress resources to v1
- releases/cluster-policies: Fixed default values
- release: v0.4.1

#### v0.4.0

> 29 September 2022

- releases: Rebuilt dist folder
- releases/policies: Added kube-core base policies
- core/releases: Reworked layers and some defaults
- releases/kyverno-policies: Added kyverno-policies with default values
- releases/kube-cleanup-operator: Updated values and switched source from local chart to remote
- releases: Added cluster-rbac
- cli/releases: Added script to generate a local release
- releases/logging-stack: Reworked logging-stack Ingress
- release: v0.4.0
- releases/kyverno: Switched to HA and increased resource limits for kyverno
- releases/logging-stack: Updated app and events dashboard

#### v0.3.27

> 23 September 2022

- releases: Added kyverno
- release: v0.3.27

#### v0.3.26

> 22 September 2022

- cli/scripts: Cleaned up some scripts and regenerated scripts-config with more docs
- release: v0.3.26
- core/releases: Adds the possibility to inject labels for logging in core releases
- releases/kps: Fixed wrong URL for mongodb_percona dashboard
- core/releases: Added logging on nginx-ingress releases by default
- releases/tekton: Sets default SA for triggers to tekton
- core/releases: Fixed typo on logging LabelTransformer
- cli/scripts: Fixed typo in cloud_gcp_setup_tekton_sf

#### v0.3.25

> 20 September 2022

- releases/chaos: Removed litmus-chaos and introduced chaos-mesh
- releases: Updated releases/dist
- releases/mongodb-atlas-operator: Added mongodb-atlas-operator release
- cli/generators: Adds terraform generator
- releases/logging: Improved logging-stack and cluster-logging default configuration, scaling and performance
- core/config: Reformatted some files
- releases/kps: Added some Grafana dashbords and reorganized some folders
- cli/generators: Fixes path in cli plopfile
- release: v0.3.25
- releases/kps: Updated mongodb and external-dns dashboards

#### v0.3.24

> 16 September 2022

- releases/logging-stack: Added Kibana dashboard auto-provisionning
- releases/cluster-logging: Allows to inject extra shared filters for all flows
- releases/cluster-logging: Added output integrations on tekton default flow
- release: v0.3.24
- core/releases: Added kube-core logging labels on nginx-ingress-controller
- releases/logging-stack: Changed min fluentd replicas to 1 by default

#### v0.3.23

> 15 September 2022

- releases/kps: Adds multiple dashboards
- releases/logging-stack: Added possibility to control min/max fluentd replicas
- release: v0.3.23
- core/cluster: Removed some namespaces that were included in log streams by default

#### v0.3.22

> 15 September 2022

- releases/cluster-logging: Changed default buffer parameters to have better AWS S3 support
- release: v0.3.22

#### v0.3.21

> 15 September 2022

- releases/cluster-logging: Fixed some unsafe conditions
- release: v0.3.21

#### v0.3.20

> 15 September 2022

- release: v0.3.20
- releases/cluster-logging: Disabled events integration by default

#### v0.3.19

> 14 September 2022

- releases/eck-operator: Upgrades to v2.4.0 and adds logic for autoscaling
- releases: Rebuilt releases
- releases/logging: Improved default values
- core/packages: Fixed test-logging package
- release: v0.3.19
- releases/logging-stack: Improved fluentbit default configuration

#### v0.3.18

> 12 September 2022

- releases: Added test-logging package
- release: v0.3.18

#### v0.3.17

> 11 September 2022

- releases: Added prometheus-adapter & KEDA
- releases: Rebuilt releases
- releases/cluster-logging: Added events integration that allows to parse and forward Kubernetes Events
- releases/cluster-logging: Improved buffer and flush configuration to have more resilient and scalable event streams
- releases/logging-stack: Improved scalability, observability and resiliency of fluentd and fluentbit
- core/config: Cleaned up some default values from core env as they are now in the underlying logging charts
- release: v0.3.17
- releases/logging-stack: Added EventTailer resource to the stack
- releases/system-jobs: Removes excessive logging in all system-jobs containers
- cli/generators: Updated release template for add release command

#### v0.3.16

> 6 September 2022

- cli/scripts: Adds more checks in branch detection before applying in auto-pr
- release: v0.3.16

#### v0.3.15

> 6 September 2022

- releases/tekton: Fixes apply & auto-merge logic in core-tag and cluster-push
- release: v0.3.15

#### v0.3.14

> 6 September 2022

- releases/tekton: Makes kube-core image in CI variable
- release: v0.3.14

#### v0.3.13

> 6 September 2022

- policies: Adds possibility to toggle kube-core policies and cluster policies
- release: v0.3.13

#### v0.3.12

> 5 September 2022

- gitops: Adds apply logic on gitops pipelines
- release: v0.3.12

#### v0.3.11

> 5 September 2022

- release: v0.3.11
- cli/scripts: Fixes detection of changes in auto-pr if all files are targeted instead of gitops config only

#### v0.3.10

> 5 September 2022

- cli/scripts: Forced secrets namespace generation to avoid CI builds deleting it
- release: v0.3.10

#### v0.3.9

> 5 September 2022

- releases: Removed base folder as it is not used anymore
- cli/scripts: Updates flux install & Various fixes and improvements
- releases: Adds flux-config to manage default flux resources
- core/templates: Moved namespace field on the kube-core release wrapper
- releases/flux: Adds podmonitor config to monitor all flux controllers
- release: v0.3.9
- releases/schema: Updated schema to include new releases

#### v0.3.8

> 3 September 2022

- releases/tekton: Updates core-tag & PR workflow
- release: v0.3.8

#### v0.3.7

> 3 September 2022

- releases: Adds container-registry-config to allow easy use of GCR in the cluster
- releases/tekton: Fixes core-tag pipeline & Makes kube-core image variable
- release: v0.3.7

#### v0.3.6

> 2 September 2022

- releases/tekton: Updates core-tag pipeline to use kube-core
- release: v0.3.6

#### v0.3.5

> 2 September 2022

- releases/tekton: Improves secret configuration
- cli/scripts: Adds tekton & SF setup script
- cli/scripts: Adds option to delete PR source branch by default on cluster auto PR
- cli/scripts: Adds variable for local keys path
- release: v0.3.5

#### v0.3.4

> 1 September 2022

- releases/tekton: Changes default run timeout and makes it configurable
- release: v0.3.4

#### v0.3.3

> 1 September 2022

- releases/tekton: Renamed and removed some resources
- release: v0.3.3

#### v0.3.2

> 1 September 2022

- releases/tekton: Reintroduces core-tag pipeline
- releases/tekton: Improves resource name templating and brings more variables in hooks
- release: v0.3.2
- cli/scripts: Updated bump script to automatically patch cli version
- releases/tekton: Fixes app-hooks git-webhooks-token reference missing

#### v0.3.1

> 30 August 2022

- release: v0.3.0
- release: v0.3.1
- cli: Fixes corePath in scripts
- scripts: Moved scripts in cli folder to package them together
- repo: Fixes .gitignore ignoring some files that should not be ignored
- cli: Reintroduced .helmignore files in releases/dist
- ci: Updated GitHub Actions Workflows
- cli: Adds basic install instructions in README
- repo: Fixes scripts line endings for npm release packaging
- cli: Bumps version to v0.1.6
- release-it: Fixes changelog generation
- cli: Adds proper chmod on scripts

#### v0.3.0

> 29 August 2022

- release: v0.3.0

#### v0.2.1

> 23 August 2022

- release: v0.1.0
- release: v0.2.0
- core: Added the possibility to deploy Patches with .release.patches
- release: v0.2.1
- scripts: Fixes kube-core apply & template commands
- cli: Fixed .gitignore breaking dev cli

#### v0.2.0

> 22 August 2022

- release: v0.2.0

#### v0.1.0

> 19 August 2022

- init: Imports all files from old kube-core repository
- init: Adds README.md
- chore: Release v0.1.0
- Initial commit
