import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../base";

export default class TestAll extends BaseCommand {
  static description = "Tests all config.";

  static examples = [`$ kube-core test:all`];

  static flags = {};

  static args = [];

  static strict = false;

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(TestAll);
    await this.utils.runClusterTestScript("commands/test/all.sh", argv);
  }
}
