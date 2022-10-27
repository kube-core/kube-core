import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../base";

export default class ApplyHelmfiles extends BaseCommand {
  static description = "Applies all helmfiles.";

  static examples = [
    `
    $ kube-core apply:helmfiles
    $ kube-core apply:helmfiles --dry-run
  `,
  ];

  static flags = {};

  static args = [];

  static strict = false;

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(ApplyHelmfiles);

    console.log("Applying helmfiles");
    const clusterHelmfiles = await this.utils.runClusterScript(
      "src/cluster/apply/helmfiles.sh",
      argv
    );
    console.log("Done applying helmfiles!");
  }
}
