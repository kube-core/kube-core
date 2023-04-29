import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../../base";

export default class ClusterSetupGCP extends BaseCommand {
  static description = "Setup local configuration and secrets for GCP integration with Crossplane";

  static examples = [`$ kube-core cluster setup gcp`];

  static flags = {};

  static args = [];

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(ClusterSetupGCP);
    await this.utils.runClusterScript("src/cloud/gcp/setup/setup.sh", argv);
  }
}
