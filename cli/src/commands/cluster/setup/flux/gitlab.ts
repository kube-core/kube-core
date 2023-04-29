import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../../../base";

export default class ClusterSetupFluxGitLab extends BaseCommand {
  static description = "Setup local configuration and secrets to use Flux with GitLab";

  static examples = [`$ kube-core cluster setup flux gitlab`];

  static flags = {};

  static args = [];

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(ClusterSetupFluxGitLab);
    await this.utils.runClusterScript("src/cluster/setup/flux/install.sh", argv);
  }
}
