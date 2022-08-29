import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../base";

export default class ScriptsList extends BaseCommand {
  static description =
    "Lists all kube-core scripts";

  static examples = [`$ kube-core scripts:list`];

  static flags = {};

  static args = [];

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(ScriptsList);
    await this.utils.runCoreScript("commands/scripts/list.sh", argv);
  }
}
