import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../base";

export default class ValuesAll extends BaseCommand {
  static description = "Gets all Values.";

  static examples = [`$ kube-core values:all`];

  static flags = {};

  static args = [];

  static strict = false;

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(ValuesAll);
    await this.utils.runCoreScript("commands/values/all.sh", argv);
  }
}
