import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../base";

export default class ApplyAll extends BaseCommand {
  static description = "Applies all kube-core config and local config.";

  static examples = [
    `
    $ kube-core apply:all
    $ kube-core apply:all --dry-run
  `,
  ];

  static flags = {};

  static args = [];

  static strict = false;

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(ApplyAll);

    console.log("Running cluster apply script");
    const clusterApply = await this.utils.runClusterScript(
      "src/cluster/apply.sh",
      argv
    );

    console.log("Done applying all config");

    // TODO: Decide if we orchestrate this from scripts or from CLI
    // Maybe refactor this, create a ApplyService and use methods from this service instead of copy paste

    // // Applying CRDs
    // console.log("Applying kube-core and local cluster CRDs (if any)")
    // const coreCrds = await this.utils.runCoreScript("commands/apply/crds.sh", argv);
    // const clusterCrds = await this.utils.runClusterScript("src/cluster/apply/crds.sh", argv);
    // console.log("Done running all CRDs upgrades!")

    // // Applying namespaces
    // console.log("Applying local cluster namespaces")
    // const clusterNamespaces = await this.utils.runClusterScript("src/cluster/apply/namespaces.sh", argv);
    // console.log("Done applying local cluster namespaces!")

    // // Applying ConfigMaps
    // console.log("Applying local cluster configmaps (if any)")
    // const clusterConfigMaps = await this.utils.runClusterScript("src/cluster/apply/configmaps.sh", argv);
    // console.log("Done applying local cluster configmaps!")

    // // Applying Secrets
    // console.log("Applying local cluster secrets (if any)")
    // const clusterSecrets = await this.utils.runClusterScript("src/cluster/apply/secrets.sh", argv);
    // console.log("Done applying local cluster secrets!")

    // // Helmfile Releases
    // console.log("Applying helmfiles")
    // const clusterHelmfiles = await this.utils.runClusterScript("src/cluster/apply/helmfiles.sh", argv);
    // console.log("Done applying helmfiles!")

    // // Applying local config
    // console.log("Applying local cluster config")
    // const clusterConfig = await this.utils.runClusterScript("src/cluster/apply/config.sh", argv);
    // console.log("Done applying local cluster config!")
  }
}
