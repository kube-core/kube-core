import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../base";

export default class ValuesCore extends BaseCommand {
  static description = "Gets Core Values.";

  static examples = [`$ kube-core values:core`];

  static flags = {};

  static args = [];

  static strict = false;

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(ValuesCore);
    await this.utils.runCoreScript("commands/values/core.sh", argv);
  }
}
