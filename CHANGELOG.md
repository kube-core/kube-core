# v0.2.0

This release brings:
- Many chart upgrades
- Improved Secrets management
- Fully automated cluster setup on GCP
- Crossplane integration for GCP
### Packages
- visitor-groups: Added to essentials package
- sloop: Removed from monitoring package

### Releases & Values
- ingress-access-operator: Updated image version to v1.1.0
- ingress-access-operator: Updated annotations in all templates and values
- ingress-access-operator: Enabled default filtering
- cert-manager: Updated chart to v1.9.1
- cert-manager: Updated chart to 6.7.5
- forecastle: Updated chart to v1.0.97
- nginx: Updated chart version to 13.1.8
- nginx-ingress-controller: Updated chart version to 9.2.28
- nginx-ingress-controller: Disabled ServiceMonitor by default
- nginx-ingress-controller: Enabled ServiceMonitor when monitoring package is active
- nginx-ingress-controller: Removed some useless values in config
- nginx-istio-ingress-controller: Disabled ServiceMonitor by default
- reloader: Injected annotations on various releases
- logging-gcs: Added release to manage GCS logging buckets
- cluster-logging: Better secret management
- crossplane: Updated to v1.9.0
- crossplane: Reworked kube-core integration to make it simpler
- crossplane: Improved naming of Crossplane ressources
- crossplane-buckets: Updated to v0.2.0
- crossplane-provider: Fixed presync hooks
- crossplane-provider-config: Fixed presync hooks
- velero: Added a patch to change credentials file path to velero.json
- velero: Upgraded chart to 2.31.3
- velero: Upgraded plugins for AWS & GCP to v1.5.0
- velero: Switched logs format to json
- velero: Disabled restic by default
- visitor-groups: Added public group & Dynamic default groups
- reloader: Better naming
- reloader: Upgraded chart jto v0.0.118
- replicator: Better naming
- replicator: Upgraded chart to 2.7.3
- polaris: Upgraded chart to 5.4.1
- sealed-secrets: Upgraded chart to 2.6.0

### Templates
- Release Secrets: Added release-secrets templating. Every kube-core release that has secrets should expose them there for easier configuration/discovery of important secrets (in releases-secrets.yaml)
- Release Secrets: Integrated with all essential, monitoring, and logging releases
- Release: Added options.injectReloaderAnnotations to easily patch all Deployments, Statefulsets and Daemonsets with reloader annotation
- Release: Added injection of .cluster.config.context in every release
- Release: Better handling of labels templating
- Release Manifests: Removed dependency towards the main release

### Scripts
- cloud_gcp_setup_setup: New script to setup everything needed on GCP for a new cluster

# v0.1.0
First OSS release
