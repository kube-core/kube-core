import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../base";

export default class ApplyConfig extends BaseCommand {
  static description = "Applies local cluster config.";

  static examples = [
    `
    $ kube-core apply:config
    $ kube-core apply:config --dry-run
  `,
  ];
  static flags = {};

  static args = [];

  static strict = false;

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(ApplyConfig);

    console.log("Applying local cluster config");
    const clusterConfig = await this.utils.runClusterScript(
      "src/cluster/apply/config.sh",
      argv
    );
    console.log("Done applying local cluster config!");
  }
}
