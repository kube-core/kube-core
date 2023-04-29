import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../../../base";

export default class ClusterSetupTektonGitLab extends BaseCommand {
  static description = "Setup local configuration and secrets to use Tekton with GitLab";

  static examples = [`$ kube-core cluster setup tekton gitlab`];

  static flags = {};

  static args = [];

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(ClusterSetupTektonGitLab);
    await this.utils.runClusterScript("src/cloud/gcp/setup/tekton/git.sh", argv);
  }
}
