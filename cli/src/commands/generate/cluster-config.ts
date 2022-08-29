import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../base";

export default class GenerateClusterConfig extends BaseCommand {
  static description =
    "Generates cluster-config.yaml from core values.";

  static examples = [`$ kube-core generate:cluster-config`];

  static flags = {};

  static args = [];

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(GenerateClusterConfig);
    await this.utils.runCoreScript("commands/generate/cluster-config.sh", argv);
  }
}
