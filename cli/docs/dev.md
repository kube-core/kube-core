`kube-core dev`
===============

Tools for kube-core development.

* [`kube-core dev mode hot-reload`](#kube-core-dev-mode-hot-reload)
* [`kube-core dev releases add chart`](#kube-core-dev-releases-add-chart)
* [`kube-core dev releases add local-chart`](#kube-core-dev-releases-add-local-chart)
* [`kube-core dev releases add release`](#kube-core-dev-releases-add-release)
* [`kube-core dev releases build`](#kube-core-dev-releases-build)

## `kube-core dev mode hot-reload`

Experimental feature. Watches changes in ./dev/config and applies them.

```
USAGE
  $ kube-core dev mode hot-reload [--remove]

FLAGS
  --remove  Forces removal of resources on file deletion

DESCRIPTION
  Experimental feature. Watches changes in ./dev/config and applies them.

EXAMPLES
  $ kube-core dev mode hot-reload
```

## `kube-core dev releases add chart`

Adds a Helm Chart to kube-core.

```
USAGE
  $ kube-core dev releases add chart

DESCRIPTION
  Adds a Helm Chart to kube-core.

EXAMPLES
  $ kube-core dev releases add chart helm-repository chart-name chart-version
```

## `kube-core dev releases add local-chart`

Adds a local Helm Chart to kube-core.

```
USAGE
  $ kube-core dev releases add local-chart

DESCRIPTION
  Adds a local Helm Chart to kube-core.

EXAMPLES
  $ kube-core dev releases add local-chart chart-name
```

## `kube-core dev releases add release`

Adds a Helmfile Release to kube-core.

```
USAGE
  $ kube-core dev releases add release

DESCRIPTION
  Adds a Helmfile Release to kube-core.

EXAMPLES
  $ kube-core dev releases add release chart-name release-name namespace
```

## `kube-core dev releases build`

Builds kube-core dist

```
USAGE
  $ kube-core dev releases build

DESCRIPTION
  Builds kube-core dist

EXAMPLES
  # Build all Releases
  $ kube-core dev releases build
  # Build everything that matches the filter (grep)
  $ kube-core dev releases build tekton
```
