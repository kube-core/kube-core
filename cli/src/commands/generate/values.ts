import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../base";

export default class GenerateValues extends BaseCommand {
  static description =
    "Work in progress feature. Generates values files for a consumer cluster.";

  static examples = [`$ kube-core generate:values`];

  static flags = {};

  static args = [];

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(GenerateValues);
    await this.utils.runCoreScript("commands/generate/values.sh", argv);
  }
}
