`kube-core values`
==================

View and manage configuration values.

* [`kube-core values all`](#kube-core-values-all)
* [`kube-core values cluster`](#kube-core-values-cluster)
* [`kube-core values core`](#kube-core-values-core)
* [`kube-core values keys`](#kube-core-values-keys)
* [`kube-core values reshape`](#kube-core-values-reshape)

## `kube-core values all`

Gets all Values.

```
USAGE
  $ kube-core values all

DESCRIPTION
  Gets all Values.

EXAMPLES
  $ kube-core values:all
```

## `kube-core values cluster`

Gets Cluster Values.

```
USAGE
  $ kube-core values cluster

DESCRIPTION
  Gets Cluster Values.

EXAMPLES
  $ kube-core values:cluster
```

## `kube-core values core`

Gets Core Values.

```
USAGE
  $ kube-core values core

DESCRIPTION
  Gets Core Values.

EXAMPLES
  $ kube-core values:core
```

## `kube-core values keys`

Gets top-level keys in kube-core values.

```
USAGE
  $ kube-core values keys

DESCRIPTION
  Gets top-level keys in kube-core values.

EXAMPLES
  $ kube-core values:keys
```

## `kube-core values reshape`

Reshape values

```
USAGE
  $ kube-core values reshape [--mode all|keys|deep|releases|environments|custom] [--deepFilterKeys <value>]
    [--releaseDimensions <value>]

FLAGS
  --deepFilterKeys=<value>     [default: cluster|environments|releases] Controls which keys will be deeply split (one
                               level)
  --mode=<option>              [default: all] The type of reshaping that will occur.
                               <options: all|keys|deep|releases|environments|custom>
  --releaseDimensions=<value>  [default: cloud|config|customExtensions|dynamicSecrets|external-secrets|extraReleaseValue
                               s|hooks|ingress|jsonPatches|labels|manifests|monitoring|options|patches|scaling|schedulin
                               g|secrets|slack|slos|strategicMergePatches|values] Controls which dimensions will be
                               added to split the releases

DESCRIPTION
  Reshape values

EXAMPLES
  $ kube-core values reshape
```
