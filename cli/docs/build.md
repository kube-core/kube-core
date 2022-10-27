`kube-core build`
=================

Build kube-core and cluster configuration.

* [`kube-core build all`](#kube-core-build-all)
* [`kube-core build config`](#kube-core-build-config)
* [`kube-core build configmaps`](#kube-core-build-configmaps)
* [`kube-core build crds`](#kube-core-build-crds)
* [`kube-core build helmfiles`](#kube-core-build-helmfiles)
* [`kube-core build namespaces`](#kube-core-build-namespaces)
* [`kube-core build secrets`](#kube-core-build-secrets)

## `kube-core build all`

Builds all config.

```
USAGE
  $ kube-core build all

DESCRIPTION
  Builds all config.

EXAMPLES
  $ kube-core build:all
```

## `kube-core build config`

Builds local config

```
USAGE
  $ kube-core build config

DESCRIPTION
  Builds local config

EXAMPLES
  $ kube-core build:config
```

## `kube-core build configmaps`

Builds ConfigMaps from local manifests

```
USAGE
  $ kube-core build configmaps

DESCRIPTION
  Builds ConfigMaps from local manifests

EXAMPLES
      $ kube-core build:configmaps
      $ kube-core build:configmaps tekton # Only builds what matches the filter (grep)
```

## `kube-core build crds`

Not implemented.

```
USAGE
  $ kube-core build crds

DESCRIPTION
  Not implemented.

EXAMPLES
  $ kube-core build:crds
```

## `kube-core build helmfiles`

Builds all helmfiles.

```
USAGE
  $ kube-core build helmfiles

DESCRIPTION
  Builds all helmfiles.

EXAMPLES
  $ kube-core build:helmfiles
```

## `kube-core build namespaces`

Generates Namespaces from manifests in config.

```
USAGE
  $ kube-core build namespaces

DESCRIPTION
  Generates Namespaces from manifests in config.

EXAMPLES
  $ kube-core build:namespaces
```

## `kube-core build secrets`

Builds Secrets from local manifests.

```
USAGE
  $ kube-core build secrets

DESCRIPTION
  Builds Secrets from local manifests.

EXAMPLES
    $ kube-core build:secrets
    $ kube-core build:secrets tekton # Only builds what matches the filter (grep)
```
