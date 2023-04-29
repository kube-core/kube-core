import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../../base";

export default class DevModeLocal extends BaseCommand {
  static description = "For kube-core releases development. Brings all dependencies charts locally under releases/local for faster development";

  static examples = [`$ kube-core dev mode local`];

  static flags = {};

  static args = [];

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(DevModeLocal);
    await this.utils.runCoreScript("commands/dev/mode/local.sh", argv);
  }
}
