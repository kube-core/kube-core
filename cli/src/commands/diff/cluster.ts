import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../base";

export default class DiffCluster extends BaseCommand {
  static description = "Runs a diff on the Cluster.";

  static examples = [`$ kube-core diff:cluster`];

  static flags = {};

  static args = [];

  static strict = false;

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(DiffCluster);
    await this.utils.runCoreScript("commands/diff/cluster.sh", argv);
  }
}
