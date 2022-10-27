import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../base";

export default class GitOpsConfigMaps extends BaseCommand {
  static description = "Builds ConfigMaps from local manifests";

  static examples = [
    `
    $ kube-core build:configmaps
    $ kube-core build:configmaps tekton # Only builds what matches the filter (grep)
    `,
  ];

  static flags = {};

  static args = [];

  static strict = false;

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(GitOpsConfigMaps);
    await this.utils.runClusterScript("src/gitops/configmaps.sh", argv);
  }
}
