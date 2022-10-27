import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../base";

export default class BuildCrds extends BaseCommand {
  static description = "Not implemented.";

  static examples = [`$ kube-core build:crds`];

  static flags = {};

  static args = [];

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(BuildCrds);
    console.log("Not implemented");
  }
}
