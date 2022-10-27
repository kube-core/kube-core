import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../base";

export default class GitOpsSecrets extends BaseCommand {
  static description = "Builds Secrets from local manifests.";

  static examples = [
    `
  $ kube-core build:secrets
  $ kube-core build:secrets tekton # Only builds what matches the filter (grep)
  `,
  ];

  static flags = {};

  static args = [];

  static strict = false;

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(GitOpsSecrets);
    await this.utils.runClusterScript("src/gitops/secrets.sh", argv);
  }
}
