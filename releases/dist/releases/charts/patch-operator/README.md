# Patch operator for K8S

![](https://banners.beyondco.de/n9%2Fpatch-operator.png?theme=light&packageManager=&packageName=n9%2Fpatch-operator&pattern=architect&style=style_1&description=Patch+your+K8S+resources+easily&md=1&showWatermark=1&fontSize=100px&images=document-text)

`patch-operator` aims to patch our deployed/running resources based on some labels/annotations. It allows us to (for
example) :

- patch service containing annotation `ingress.neo9.io/expose: "true"` by applying label `ingress.neo9.io/expose:
  "true"` automatically
- patch pod/deployment containing name `elasticsearch` by applying labels `app.kubernetes.io/name=elasticsearch`,
  `app.kubernetes.io/instance=elasticsearch`

**It can't be used to patch a resource using wildcard/regex data because it uses the underlying K8S label/annotations
selectors.**

## Installation

```bash
kubectl apply -f https://raw.githubusercontent.com/redhat-cop/patch-operator/main/config/crd/bases/redhatcop.redhat.io_patches.yaml
helm install my-patch-operator n9/patch-operator --namespace patch-operator --create-namespace
```

### Deploy your first patch

Take a look at this example patch :

```yaml
apiVersion: redhatcop.redhat.io/v1alpha1
kind: Patch
metadata:
  name: elasticsearch-name-instance-patch
  namespace: patch-operator
spec:
  serviceAccountRef:
    name: controller-manager
  patches:
     elasticsearch-name-instance-patch:
      targetObjectRef:
        apiVersion: apps/v1
        kind: Deployment
        name: elasticsearch
        namespace: elasticsearch-operator
      patchType: application/strategic-merge-patch+json
      patchTemplate: |
        spec:
          template:
            metadata:
              labels:
                app.kubernetes.io/name: elasticsearch
                app.kubernetes.io/instance: elasticsearch
```

You can deploy it using `kubectl apply -f elasticsearch-name-instance-patch.yml`.

## Options
### RBAC

By default, the RBAC is configured to patch the following resources :

- `pods`
- `services`
- `namespaces`
- `apps.deployments`

This can be modified using `values.yaml` directly.

### TLS/Webhooks

The original chart comes with a `certbot` automation : there's no choice by default to not use HTTPS internally. Maybe
we can plan to adjust this behavior directly from the chart. If you don't want to use `certbot`, you'll have to create
to secret containing certificats :

- `patch-operator-certs`
- `webhook-server-certs`

In order to test this chart, I've added an option to disable webhooks, because they don't seem to work well using
`minikube`. You can disable them during your test using `--set enableWebhooks=false` flag.

## See more

- https://github.com/redhat-cop/patch-operator
