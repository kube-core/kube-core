import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../../base";

export default class GitopsOverlaysApply extends BaseCommand {
  static description = "Applies overlays on gitops config";

  static examples = [`$ kube-core gitops overlays apply`];

  static flags = {};

  static args = [];

  static strict = false;

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(GitopsOverlaysApply);
    await this.utils.runClusterScript("src/gitops/overlays/apply.sh", argv);
  }
}
