`kube-core absorb`
==================

Patch some resources with Helm metadata/labels, and import them quickly as local charts in kube-core.

* [`kube-core absorb`](#kube-core-absorb)

## `kube-core absorb`

Patch some resources with Helm metadata/labels, and import them quickly as local charts in kube-core.

```
USAGE
  $ kube-core absorb [--patchOnly] [--force]

FLAGS
  --force      Force applying the patch/import if Helm metadata/labels are already present on the resources
  --patchOnly  Only patches the resources (does not import the resources in a local release)

DESCRIPTION
  Patch some resources with Helm metadata/labels, and import them quickly as local charts in kube-core.

EXAMPLES
  # Absorbing a resource
  $ kubectl get ns cert-manager -o json | kube-core absorb
  # Absorbing a list of resources
  $ kubectl get secrets -n tekton-pipelines -o json | kube-core absorb
  # Absorbing resources that already have Helm release metadata/labels
  $ kubectl get sealedsecrets -n tekton-pipelines -o json | kube-core absorb --force
```

_See code: [dist/commands/absorb/index.ts](https://github.com/kube-core/cli/blob/v0.7.4/dist/commands/absorb/index.ts)_
