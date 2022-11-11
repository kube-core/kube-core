`kube-core generate`
====================

Generate various resources.

* [`kube-core generate cluster-config`](#kube-core-generate-cluster-config)
* [`kube-core generate helmfiles`](#kube-core-generate-helmfiles)
* [`kube-core generate local`](#kube-core-generate-local)
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
  $ kube-core generate helmfiles [--lib] [--commons] [--core] [--applications] [--services] [--envs <value>]
    [--defaultEnvs] [--localRefs]

FLAGS
  --[no-]applications  Generates applications helmfiles for all environments. Provide --envs or --defaultEnvs with it.
                       Enabled by default. Use --no-applications to disable.
  --[no-]commons       Generates common.helmfile.yaml.gotmpl to share common configuration between all helmfiles.
                       Enabled by default. Use --no-commons to disable.
  --[no-]core          Generates core, cluster and local helmfiles to allow using kube-core platform. Enabled by
                       default. Use --no-core to disable.
  --defaultEnvs        Use it to generate default kube-core envs for a quickstart. Use it with --applications and/or
                       --services.
  --envs=<value>...    [default: ] A comma separated list of envs to generate. Use it with --applications and/or
                       --services.
  --[no-]lib           Generates helmfiles/lib folder, with templates and utility functions. Enabled by default. Use
                       --no-lib to disable.
  --localRefs          Writes down local helmfile refs instead of using KUBE_CORE_LOCAL_CORE_PATH env var
  --[no-]services      Generates services helmfiles for all environments. Provide --envs or --defaultEnvs with it.
                       Enabled by default. Use --no-services to disable.

DESCRIPTION
  Generate helmfiles to setup your project quickly

EXAMPLES
  # Platform only
  $ kube-core generate helmfiles
  # Platform + Default Envs
  $ kube-core generate helmfiles --defaultEnvs
  # Platform + Any Env
  $ kube-core generate helmfiles --envs=integration,validation,preproduction,production
  $ kube-core generate helmfiles --envs=integration --envs=validation --envs=preproduction --envs=production
  # Platform + Default Envs + Any Env
  $ kube-core generate helmfiles --defaultEnvs --envs=qa,test
  # Disabling what you don't need
  $ kube-core generate helmfiles --no-lib --no-core --no-services --defaultEnvs
```

## `kube-core generate local`

Generates all local folders that are used by kube-core

```
USAGE
  $ kube-core generate local

DESCRIPTION
  Generates all local folders that are used by kube-core

EXAMPLES
  $ kube-core generate local
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
