import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../../base";

export default class ClusterSetupSealedSecrets extends BaseCommand {
  static description = "Adds entry for current cluster in your kubeconfig.";

  static examples = [`$ kube-core cluster setup sealed-secrets`];

  static flags = {};

  static args = [];

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(ClusterSetupSealedSecrets);
    await this.utils.runClusterScript("src/cluster/setup/sealedsecrets/get-certificate.sh", argv);
  }
}
