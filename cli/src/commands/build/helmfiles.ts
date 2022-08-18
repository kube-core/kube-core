import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../base";

export default class BuildHelmfiles extends BaseCommand {
  static description = "Builds all helmfiles.";

  static examples = [`$ kube-core build:helmfiles`];

  static flags = {};

  static args = [];

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(BuildHelmfiles);
    await this.utils.runClusterScript("src/gitops/helmfile.sh", argv);
  }
}
