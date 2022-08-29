import { Command, Flags } from "@oclif/core";
import BaseCommand from "../base";

export default class CorePath extends BaseCommand {
  static description = "Prints kube-core local path.";

  static examples = [`$ kube-core path`];

  static flags = {};

  static args = [];

  static strict = false;

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(CorePath);
    await this.utils.runClusterScript("src/utils/read-core-path.sh", argv);
  }
}
