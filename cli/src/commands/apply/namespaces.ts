import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../base";

export default class ApplyNamespaces extends BaseCommand {
  static description = "Applies all Namespaces.";

  static examples = [
    `
    $ kube-core apply:namespaces
    $ kube-core apply:namespaces --dry-run
  `,
  ];

  static flags = {};

  static args = [];

  static strict = false;

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(ApplyNamespaces);

    console.log("Applying local cluster namespaces");
    const clusterNamespaces = await this.utils.runClusterScript(
      "src/cluster/apply/namespaces.sh",
      argv
    );
    console.log("Done applying local cluster namespaces!");
  }
}
