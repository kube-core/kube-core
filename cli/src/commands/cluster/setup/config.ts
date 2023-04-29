import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../../base";

export default class ClusterSetupConfig extends BaseCommand {
  static description = "Generates cluster-config.yaml from core values.";

  static examples = [`$ kube-core cluster setup config`];

  static flags = {};

  static args = [];

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(ClusterSetupConfig);
    await this.utils.runCoreScript("commands/generate/cluster-config.sh", argv);
  }
}
