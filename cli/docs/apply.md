`kube-core apply`
=================

Apply kube-core and cluster configuration.

* [`kube-core apply all`](#kube-core-apply-all)
* [`kube-core apply config`](#kube-core-apply-config)
* [`kube-core apply configmaps`](#kube-core-apply-configmaps)
* [`kube-core apply crds`](#kube-core-apply-crds)
* [`kube-core apply helmfiles`](#kube-core-apply-helmfiles)
* [`kube-core apply namespaces`](#kube-core-apply-namespaces)
* [`kube-core apply secrets`](#kube-core-apply-secrets)

## `kube-core apply all`

Applies all kube-core config and local config.

```
USAGE
  $ kube-core apply all

DESCRIPTION
  Applies all kube-core config and local config.

EXAMPLES
      $ kube-core apply:all
      $ kube-core apply:all --dry-run
```

## `kube-core apply config`

Applies local cluster config.

```
USAGE
  $ kube-core apply config

DESCRIPTION
  Applies local cluster config.

EXAMPLES
      $ kube-core apply:config
      $ kube-core apply:config --dry-run
```

## `kube-core apply configmaps`

Applies all local ConfigMaps.

```
USAGE
  $ kube-core apply configmaps

DESCRIPTION
  Applies all local ConfigMaps.

EXAMPLES
      $ kube-core apply:configmaps
      $ kube-core apply:configmaps --dry-run
```

## `kube-core apply crds`

Applies CRDs from kube-core and local cluster CRDs.

```
USAGE
  $ kube-core apply crds

DESCRIPTION
  Applies CRDs from kube-core and local cluster CRDs.

EXAMPLES
      $ kube-core apply:crds
      $ kube-core apply:crds --dry-run
      $ kube-core apply:crds --dry-run=client # client side
      $ kube-core apply:crds --dry-run=server # server side (if applicable)
      $ kube-core apply:crds --filter=velero # Only what matches the filter
```

## `kube-core apply helmfiles`

Applies all helmfiles.

```
USAGE
  $ kube-core apply helmfiles

DESCRIPTION
  Applies all helmfiles.

EXAMPLES
      $ kube-core apply:helmfiles
      $ kube-core apply:helmfiles --dry-run
```

## `kube-core apply namespaces`

Applies all Namespaces.

```
USAGE
  $ kube-core apply namespaces

DESCRIPTION
  Applies all Namespaces.

EXAMPLES
      $ kube-core apply:namespaces
      $ kube-core apply:namespaces --dry-run
```

## `kube-core apply secrets`

Applies all Secrets.

```
USAGE
  $ kube-core apply secrets

DESCRIPTION
  Applies all Secrets.

EXAMPLES
      $ kube-core apply:secrets
      $ kube-core apply:secrets --dry-run
```
