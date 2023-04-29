import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../../base";

export default class ClusterSetupGenerateTerraform extends BaseCommand {
  static description = "Generates terraform configuration for your cluster";

  static examples = [`$ kube-core cluster setup terraform`];

  static flags = {};

  static args = [];

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(ClusterSetupGenerateTerraform);
    await this.utils.runCoreScript("src/cluster/terraform/generate.sh", argv);
  }
}
