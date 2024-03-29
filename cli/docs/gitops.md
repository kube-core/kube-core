`kube-core gitops`
==================

Explore and manage your GitOps config

* [`kube-core gitops config`](#kube-core-gitops-config)
* [`kube-core gitops config diff`](#kube-core-gitops-config-diff)
* [`kube-core gitops config find`](#kube-core-gitops-config-find)
* [`kube-core gitops config read`](#kube-core-gitops-config-read)
* [`kube-core gitops config search`](#kube-core-gitops-config-search)
* [`kube-core gitops overlays apply`](#kube-core-gitops-overlays-apply)

## `kube-core gitops config`

Index your GitOps config, required for gitops config diff

```
USAGE
  $ kube-core gitops config [--rebuildNext] [--rebuildCurrent]

FLAGS
  --rebuildCurrent  Force rebuild current index
  --rebuildNext     Force rebuild next index

DESCRIPTION
  Index your GitOps config, required for gitops config diff

EXAMPLES
  # Build your index when git workspace is clean. This generates: ./data/full.js
  $ kube-core gitops config index
  # Make some changes
  $ ...
  # Build your new config
  $ kube-core build all
  # Build your next index. This generates: ./data/next-full.js
  $ kube-core gitops config index
  # Force refresh example
  $ git stash && kube-core gitops config index --rebuildCurrent
  $ git stash apply && kube-core build all && gitops config index --rebuildNext
```

## `kube-core gitops config diff`

Search your GitOps Config

```
USAGE
  $ kube-core gitops config diff [--include <value>] [--exclude <value>] [--filter <value>] [--color]

FLAGS
  --[no-]color       jq filter that will be used to prepare before diff
  --exclude=<value>  Grep filter
  --filter=<value>   jq filter that will be used to prepare before diff
  --include=<value>  Grep filter

DESCRIPTION
  Search your GitOps Config

EXAMPLES
  # Global gitops diff
  $ kube-core gitops config diff
  # Chain include and exclude
  $ kube-core gitops config diff --include secret --exclude "rabbitmq|mongodb"
  # Advanced diff, using include, exclude and filter
  $ kube-core gitops config diff --include "preproduction|production" --exclude namespace --filter='select(to_entries | length > 0) | to_entries | . | map({(.key): {"labels":.value.metadata.labels}}) | add'
  # Get what will be applied for each resource as json
  $ kube-core gitops config diff --no-color | grep ">" | sed 's|>||' | awk '{$1=$1};1' | gron --ungron
```

## `kube-core gitops config find`

Find files in your GitOps config

```
USAGE
  $ kube-core gitops config find

DESCRIPTION
  Find files in your GitOps config

EXAMPLES
  # List all resources
  $ kube-core gitops config find
  # List resources with a matching path
  $ kube-core gitops config find velero
```

## `kube-core gitops config read`

Read your GitOps Config

```
USAGE
  $ kube-core gitops config read [-o <value>] [-q <value>]

FLAGS
  -o, --output=<value>  [default: yaml] Output format. yaml|json
  -q, --query=<value>   A valid basic jq expression to filter on. If you need to use complex queries or jq args, use -o
                        json instead and pipe to jq yourself.

DESCRIPTION
  Read your GitOps Config

EXAMPLES
  # Read all config as yaml
  $ kube-core gitops config read
  # Read all config as json
  $ kube-core gitops config read -o json
  # List cluster-wide resources
  $ kube-core gitops config read | yq '.items[] | select(.metadata.namespace==null) | (.kind + "/" + .metadata.name)'
  # List Deployments
  $ kube-core gitops config read -o json | jq '.items[] | select(.kind=="Deployment)'
  # List Namespaces
  $ kube-core gitops config read '.items[] | select(.kind=="Namespace") | .metadata.name'
```

## `kube-core gitops config search`

Search your GitOps Config

```
USAGE
  $ kube-core gitops config search

DESCRIPTION
  Search your GitOps Config

EXAMPLES
  # Search by path in config
  $ kube-core gitops config search /config/velero/deployment
  $ kube-core gitops config search velero/deployment
  $ kube-core gitops config search deployment/velero
  # Search any term. Get all matches in every resource, with partial context.
  $ kube-core gitops config search root
  # Stream all resources line by line. You do the search!
  $ kube-core gitops config search
  # Custom search: find any reference of "nginx" in deployments and spec.containers
  $ kube-core gitops config search | grep /deployment | grep spec.containers | grep nginx
  # Make your search results human readable
  $ kube-core gitops config search | grep /deployment | grep spec.containers | grep nginx | gron --ungron | yq -P -C
  # Hilight your matches
  $ kube-core gitops config search | grep /deployment | grep spec.containers | grep nginx | gron --ungron | yq -P -C | grep --color=always -E 'nginx|$'
```

## `kube-core gitops overlays apply`

Applies overlays on gitops config

```
USAGE
  $ kube-core gitops overlays apply

DESCRIPTION
  Applies overlays on gitops config

EXAMPLES
  $ kube-core gitops overlays apply
```
