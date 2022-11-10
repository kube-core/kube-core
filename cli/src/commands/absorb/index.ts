import StdinCommand from "../../stdin";
import { Flags } from "@oclif/core";
import upath from "upath";

export default class Absorb extends StdinCommand {
  static description =
    "Patch some resources with Helm metadata/labels, and import them quickly as local charts in kube-core.";

  static examples = [`# Absorbing a resource
$ kubectl get ns cert-manager -o json | kube-core absorb
# Absorbing a list of resources
$ kubectl get secrets -n tekton-pipelines -o json | kube-core absorb
# Absorbing resources that already have Helm release metadata/labels
$ kubectl get sealedsecrets -n tekton-pipelines -o json | kube-core absorb --force`];

  static flags = {
    patchOnly: Flags.boolean({
      description: "Only patches the resources (does not import the resources in a local release)",
      hidden: false,
      required: false,
    }),
    force: Flags.boolean({
      description: "Force applying the patch/import if Helm metadata/labels are already present on the resources",
      hidden: false,
      required: false,
    }),
  };
  static args = []

  async patchLocalSecret(namespace, name) {
    let patchTemplate = {"metadata": {"annotations": {"meta.helm.sh/release-name":`local-secrets-${namespace}`, "meta.helm.sh/release-namespace":`${namespace}`}, "labels": {"app.kubernetes.io/managed-by": "Helm"}}}
    let kubectlCommand = [`--context=${this.clusterConfig.cluster.config.context}`,"patch", "secret", "-n", namespace, name, "--patch", JSON.stringify(patchTemplate)]
    // console.log(kubectlCommand.join(" "))
    const result = await this.utils.cliStream("kubectl", kubectlCommand, { maxBuffer: 900_000_000 })
    return result.stdout
  }
  async patchLocalSealedSecret(namespace, name) {
    let patchTemplate = {"metadata": {"annotations": {"meta.helm.sh/release-name":`local-secrets-${namespace}`, "meta.helm.sh/release-namespace":`${namespace}`}, "labels": {"app.kubernetes.io/managed-by": "Helm"}}}
    let kubectlCommand = [`--context=${this.clusterConfig.cluster.config.context}`,"patch", "sealedsecret", "-n", namespace, name, "--patch", JSON.stringify(patchTemplate), "--type=merge"]
    // console.log(kubectlCommand.join(" "))
    const result = await this.utils.cliStream("kubectl", kubectlCommand, { maxBuffer: 900_000_000 })
    return result.stdout
  }
  async patchNamespacedNamespace(namespace, name) {
    let patchTemplate = {"metadata": {"annotations": {"meta.helm.sh/release-name":`ns-${name}`, "meta.helm.sh/release-namespace":`${namespace}`}, "labels": {"app.kubernetes.io/managed-by": "Helm"}}}
    let kubectlCommand = [`--context=${this.clusterConfig.cluster.config.context}`,"patch", "namespace", "-n", namespace, name, "--patch", JSON.stringify(patchTemplate)]
    // console.log(kubectlCommand.join(" "))
    const result = await this.utils.cliStream("kubectl", kubectlCommand, { maxBuffer: 900_000_000 })
    return result.stdout
  }
  async patchGlobalNamespace(name) {
    let patchTemplate = {"metadata": {"annotations": {"meta.helm.sh/release-name":`ns-${name}`, "meta.helm.sh/release-namespace":`${name}`}, "labels": {"app.kubernetes.io/managed-by": "Helm"}}}
    let kubectlCommand = [`--context=${this.clusterConfig.cluster.config.context}`,"patch", "namespace", name, "--patch", JSON.stringify(patchTemplate)]
    // console.log(kubectlCommand.join(" "))
    const result = await this.utils.cliStream("kubectl", kubectlCommand, { maxBuffer: 900_000_000 })
    return result.stdout
  }


  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(Absorb);

      let command
      let additionnalArgs = []
      if(!flags.patchOnly) {
        console.error('Importing resources is not yet available. Use kube-core absorb --patchOnly')
        return
      }
      let data = JSON.parse(Absorb.stdin)
      // console.log(data)

      if(!data.items) {
        let tmpdata = data
        tmpdata = {items: [data]}
        data = tmpdata
      }
      for (let item of data.items) {
        let kind = item.kind
        let apiVersion = item.apiVersion
        let namespace = item.metadata.namespace
        let name = item.metadata.name
        let itemPath = `${apiVersion}/${kind}/${namespace}/${name}`

        if(item.metadata) {
          if(item.metadata.annotations) {
            if(!flags.force && (item.metadata.annotations["meta.helm.sh/release-name"] || item.metadata.annotations["meta.helm.sh/release-namespace"])) {
              console.warn(`${itemPath} already has some Helm release metadata. Use --force to absorb.`)
              continue
            }
          }
          if(item.metadata.labels) {
            if(!flags.force && (item.metadata.labels["app.kubernetes.io/managed-by"])) {
              console.warn(`${itemPath} already has some Helm release labels. Use --force to absorb.`)
              continue
            }
          }
        }

        // console.log(`Trying to absorb ${namespace}/${kind}/${name} ...`)
        if((kind === "Secret" && apiVersion == "v1") || (kind === "SealedSecret" && apiVersion == "bitnami.com/v1alpha1")) {
          // console.log(`Absorbing ${itemPath}`)
          let result
          if(kind === "Secret") {
            result = await this.patchLocalSecret(namespace, name)
          } else if(kind === "SealedSecret") {
            result = await this.patchLocalSealedSecret(namespace, name)
          }
          console.log(result)
          if(flags.patchOnly) {
            // console.log("Patching is done, aborting absorption because --patchOnly was supplied.")
            continue
          } else {
            // console.warn("Full absorption not supported yet. Use --patchOnly and import/apply them manually.")
          }

        } else if (kind === "Namespace" && apiVersion == "v1") {
          // console.log(`Absorbing ${itemPath}`)
          if(namespace === undefined) {
            let result = await this.patchGlobalNamespace(name)
            console.log(result)
            if(flags.patchOnly) {
              // console.log("Patching is done, aborting absorption because --patchOnly was supplied.")
              continue
            } else {
              // console.warn("Full absorption not supported yet. Use --patchOnly and import/apply them manually.")
            }
          } else if (namespace !== undefined) {
            let result = await this.patchNamespacedNamespace(namespace, name)
            console.log(result)
            if(flags.patchOnly) {
              // console.log("Patching is done, aborting absorption because --patchOnly was supplied.")
              continue
            } else {
              // console.warn("Full absorption not supported yet. Use --patchOnly and import/apply them manually.")
            }
          }

        } else {
          console.warn(`Patching/Absorbing not supported for: ${kind}`)
        }
      }

    }

}
