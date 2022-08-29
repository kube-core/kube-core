import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../base";

export default class BuildAll extends BaseCommand {
  static description = "Builds all config.";

  static examples = [`$ kube-core build:all`];

  static flags = {};

  static args = [];

  static strict = false;

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(BuildAll);
    await this.utils.runClusterScript("build.sh", argv);
  }
}
