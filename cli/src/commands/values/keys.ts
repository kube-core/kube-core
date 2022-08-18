import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../base";

export default class ValuesKeys extends BaseCommand {
  static description = "Gets top-level keys in kube-core values.";

  static examples = [`$ kube-core values:keys`];

  static flags = {};

  static args = [];

  static strict = false;

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(ValuesKeys);
    await this.utils.runCoreScript("commands/values/keys.sh", argv);
  }
}
