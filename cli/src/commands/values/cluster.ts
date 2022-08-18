import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../base";

export default class ValuesCluster extends BaseCommand {
  static description = "Gets Cluster Values.";

  static examples = [`$ kube-core values:cluster`];

  static flags = {};

  static args = [];

  static strict = false;

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(ValuesCluster);
    await this.utils.runCoreScript("commands/values/cluster.sh", argv);
  }
}
