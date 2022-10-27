`kube-core workspace`
=====================

Quickly open important URLs from your cluster.

* [`kube-core workspace open`](#kube-core-workspace-open)

## `kube-core workspace open`

Quickly open important URLs from your cluster.

```
USAGE
  $ kube-core workspace open [-n <value>]

FLAGS
  -n, --namespace=<value>  [default: default] namespace to use

DESCRIPTION
  Quickly open important URLs from your cluster.

EXAMPLES
      $ kube-core workspace open # Opens first host on every ingress cluster-wide matching: -l workspace.kube-core.io/name=default
      $ kube-core workspace open logging # Opens first host on every ingress cluster-wide matching: -l workspace.kube-core.io/name=logging
      $ kube-core workspace open all # Opens first host on every ingress cluster-wide
      $ kube-core workspace open all -n integration  # Opens first host on every ingress in integration Namespace
      $ kube-core workspace open admin -n integration  # Opens first host on every ingress in integration Namespace matching: -l workspace.kube-core.io/name=admin
```
