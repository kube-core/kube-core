import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../base";

export default class DiffAll extends BaseCommand {
  static description = "Runs a diff.";

  static examples = [`$ kube-core diff:all`];

  static flags = {};

  static args = [];

  static strict = false;

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(DiffAll);
    await this.utils.runCoreScript("commands/diff/all.sh", argv);
  }
}
