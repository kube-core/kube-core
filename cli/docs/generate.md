`kube-core generate`
====================

Generate various resources.

* [`kube-core generate cluster-config`](#kube-core-generate-cluster-config)
* [`kube-core generate helmfiles`](#kube-core-generate-helmfiles)
* [`kube-core generate values`](#kube-core-generate-values)

## `kube-core generate cluster-config`

Generates cluster-config.yaml from core values.

```
USAGE
  $ kube-core generate cluster-config

DESCRIPTION
  Generates cluster-config.yaml from core values.

EXAMPLES
  $ kube-core generate:cluster-config
```

## `kube-core generate helmfiles`

Generate helmfiles to setup your project quickly

```
USAGE
  $ kube-core generate helmfiles [--quickstart] [--classic]

FLAGS
  --classic     Generate environments: integration, validation, preproduction, production
  --quickstart  Generate everything to get started

DESCRIPTION
  Generate helmfiles to setup your project quickly

EXAMPLES
  # Generate "quickstart" helmfiles 
  $ kube-core generate helmfiles --quickstart
  # Generate "classic" helmfiles (inte,valid,preprod,prod)
  $ kube-core generate helmfiles --classic
```

## `kube-core generate values`

Quickly generate layers from the core and merges with your local config if already existing

```
USAGE
  $ kube-core generate values

DESCRIPTION
  Quickly generate layers from the core and merges with your local config if already existing

EXAMPLES
  $ kube-core generate values
```
