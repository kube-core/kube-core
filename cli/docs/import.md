`kube-core import`
==================

Import resources from a cluster.

* [`kube-core import manifests`](#kube-core-import-manifests)
* [`kube-core import secrets`](#kube-core-import-secrets)

## `kube-core import manifests`

Quickly import some manifests to a local release.

```
USAGE
  $ kube-core import manifests -n <value> [--outputDir <value>]

FLAGS
  -n, --namespace=<value>  (required) The namespace to import manifests in. Required.
  --outputDir=<value>      The directory to output imported manifests. Defaults to ./local/releases

DESCRIPTION
  Quickly import some manifests to a local release.

EXAMPLES
  # Importing some manifests to a local release
  $ curl -s https://raw.githubusercontent.com/opencost/opencost/develop/kubernetes/opencost.yaml | kube-core import manifests
```

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
