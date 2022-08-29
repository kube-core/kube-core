import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../base";

export default class BuildConfig extends BaseCommand {
  static description = "Builds local config";

  static examples = [`$ kube-core build:config`];

  static flags = {};

  static args = [];

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(BuildConfig);
    await this.utils.runClusterScript("src/gitops/build.sh", argv);
  }
}
