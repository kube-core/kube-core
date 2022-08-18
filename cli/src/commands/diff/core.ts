import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../base";

export default class DiffCore extends BaseCommand {
  static description = "Runs a diff on the Core.";

  static examples = [`$ kube-core diff:core`];

  static flags = {};

  static args = [];

  static strict = false;

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(DiffCore);
    await this.utils.runCoreScript("commands/diff/core.sh", argv);
  }
}
