import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../../base";

export default class DevModeDev extends BaseCommand {
  static description = "For kube-core releases development. Switches dist releases references to local releases in kube-core.";

  static examples = [`$ kube-core dev mode dev`];

  static flags = {};

  static args = [];

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(DevModeDev);
    await this.utils.runCoreScript("commands/dev/mode/dev.sh", argv);
  }
}
