`kube-core import`
==================

Import resources from a cluster.

* [`kube-core import secrets`](#kube-core-import-secrets)

## `kube-core import secrets`

Imports secrets from a namespace in the cluster to local manifests.

```
USAGE
  $ kube-core import secrets

DESCRIPTION
  Imports secrets from a namespace in the cluster to local manifests.

EXAMPLES
    $ kube-core import:secrets namespace # All Secrets in the Namespace
    $ kube-core import:secrets namespace filter # Secrets with a name that matches the filter
```
