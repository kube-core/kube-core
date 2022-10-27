import { Command, Flags } from "@oclif/core";
import BaseCommand from "../base";

export default class ValuesCluster extends BaseCommand {
  static description = "Prints kube-core version.";

  static examples = [`$ kube-core version`];

  static flags = {};

  static args = [];

  static strict = false;

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(ValuesCluster);
    this.log(this.config.pjson.version);
  }
}
