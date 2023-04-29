import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../../base";

export default class ClusterSetupContext extends BaseCommand {
  static description = "Adds entry for current cluster in your kubeconfig.";

  static examples = [`$ kube-core cluster setup context`];

  static flags = {};

  static args = [];

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(ClusterSetupContext);
    await this.utils.runClusterScript("src/cloud/gcp/setup/kubeconfig/get-context.sh", argv);
  }
}
