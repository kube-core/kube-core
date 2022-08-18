# 1.3.1
- Fixed default command for initContainer
# 1.3.0
- Add possibility to set a secret env values as optional for deployment
# 1.2.2
- Fixed duplicated flux manifests generation.
# 1.2.1
- Fixed flux ImageUpdateAutomation setters in deployment, and disabled ImageUpdateAutomation by default.
# 1.2.0
- Added flux integration (.Values.flux.enabled)
# 1.1.0
- Added .Values.initContainer to inject some init container.
# 1.0.0

## Global

### Naming convention

- Kubernetes application name (for labels selector) use a new logic
  - Default value is the name of the release
  - If the name of the release has the namespace (or environnement) as a prefix, it will be trimmed for naming ressources
  - `.Values.name.appNameOverride` can be used to set a desired name if different
- K8S ressources name template use a new logic
  - By default, use the name of the app, following previous convention
  - `.Values.name.templatedNameOverride` can be used to override the name of ressources created by the chart
  - This value should not required to be override except to allow multiple deployment of one app in the same namespace (or environnement)
- Globally change value mapping to better match name of affected ressources and spec.
- Convention to set a prefix `additional` in front of an existing value, to duplicate entry when multiple input are required (yaml merge issue from garden & helmfile)
- Convention to set a suffix `Map` to rename any value, that could be declared as a map instead of a table input (yaml merge issue from garden & helmfile)

### Chart

- `appVersion` : set to latest, ensure an image can be pulled if not set in values, should also explicit the requirement to set a tag
- `kubeVersion` : chart compatibility from k8s 1.10 to < 1.25

### Values

- Current value file incorporate up-to-date commented example for each available input
- Migrated value :
  - Each top key should match a k8s ressource and/or a extra functionnality/integration
  - Global or bottom key used only for a specific ressource were moved to the relative top named key
  - When available bottom keys value are overriding the top keys value during templating
- Renamed value :
  - Most keys were renamed to match accordingly with the spec edited in the k8s ressources
  - Set convention for a named prefix `additional` in front of key value which need different input for the same templating usage (yaml merge related issue)
  - Deleted duplicated entry outside the introduced convention.
- Values used by multiple k8s ressources templating or for specific neo9 api integration, are set unders `.Values.api`
- Some values are duplicated in `.Values.global`, this is meant as an integration for catalogue parent-chart, subchart values override global values

## Templates

### Helpers

- Major change in global naming templates (check naming convention)
- Fix labels using the app version
- Propagate labels & selectorLabels to required k8s ressource
- Additional logic for clusterRoleName to use not generetad by chart
- Additional logic for environnement (or namespace) of the release
- Additional logic for api type node and java
  - Integrate different default env values from environnement logic
  - Integrate different default healtcheck path & port
  - Integrate different default metrics port
  - Integrate specific service labels `spring-boot: "true"` for java api

### Deployment & Pod

- Dissociate multiple values between `.Values.deployment` & `.Values.pod`, to separate same name bottom key that affect only deployment and those affecting only pods templated by the deployment
- Migrate all type of env values to `.Values.pod.env`
- Migrate all type of mounted volumes to `.Values.pod.mounts`

### Ingress

- Add support for apiVersion `networking.k8s.io/v1`
- Breaking change on `paths` declaration to match with new apiVersion compatibility
- `globalEasyTls` is now exclusive with `tls` to avoid templating error
- `globalEasyTls` now create certificate secret with format `{{ .host | replace "." "-" }}-tls-cert`
- Dissociate `hosts` & `additionalHosts` with same capacites for yaml merge purpose

### Service

- Change between `port` & `targetPort`, port being the port made available by the service, targePort being the port (number or name) to listen on the pods
- Removal of labels `tier` & `metrics`
- Additional labels for `spring-boot: "true"` set when global values set on java api
- Major change on `service.additionalPorts` to define service ports and relative pods endpoints

### Virtual service

- Value key moved to `Values.istio`

### Config Map

- Removed map value `Values.pods.configmap` to replace with table `Values.configMap`
- Add possibility to create multiple configmap from chart

### Pod Disruption Budget

- Add support for apiVersion `policy/v1`
- Map value under `Values.pdb`

### Cluster Role & Binding

- Add namespace in name to create a Cluster Role (avoid non namespaced ressources conflict)
- Add logic to bind the service account to a cluster role not created by chart

### PVC

- New only input is a table from `Values.pod.mounts.pvc`
- `storageClassName` is now set as a spec (annotations planned to deprecate)
- If not set, default size is set to 10G

### InitJob

- Migrate `.Values.pod.priorityClassName` to `.Values.initJob.priorityClassName`
### Healtcheck

- Default value are set depending on apiType, override by those set under `.Values.healthCheck`
- Value under `.Values.healtCheck.(liveness/readiness)` override values for corresponding probe

### Metrics & Service monitor

- Default port value is set depending on apiType, override by those set under `.Values.metrics.port`
- `.Values.metrics.serviceMonitor.enabled` deploy a service monitor for kube prometheus stack which will monitor pod deployed by the chart
- Removed values relative to envoy, need test to implement fully

# 0.11.0

- Expose hook-delete-policy for init job, fix regression required by catalogue deployment

# 0.10.0

- Add capabilities to use a custom environment variable on mounted secrets

# 0.9.1

- Changes hooks weight to 1 for all hooks (allows parallel execution)
# 0.9.0

- Allow to add custom labels on deployment

# 0.8.0

- Feat easy tls also parse custom hosts

# 0.7.1

- Fix image `tag` or `digest` can be a number

# 0.7.0

- Add the ability to generate a configMap

# 0.6.1

- Fixes regression on .Values.name to define container.name in deployment

# 0.6.0

- Allow to combine hosts and customHosts for ingress

# 0.5.0

- Fix missing volumes in templates generation

# 0.4.0

- Add custom ingress rules

# 0.2.1

- Fix ingress missing labels

# 0.2.0

- Allow to attach cluster role and binding directly in chart

# 0.1.0

- Init n9 api from node-api and java-api

