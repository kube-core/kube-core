import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../base";

export default class BuildNamespaces extends BaseCommand {
  static description = "Generates Namespaces from manifests in config.";

  static examples = [`$ kube-core build:namespaces`];

  static flags = {};

  static args = [];

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(BuildNamespaces);

    await this.utils.runClusterScript("src/gitops/utils/generate-namespaces.sh", argv);
  }
}
