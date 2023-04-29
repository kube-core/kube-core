import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../../base";

export default class DevModeProd extends BaseCommand {
  static description = "For kube-core releases development. Switches local releases references to dist releases in kube-core.";

  static examples = [`$ kube-core dev mode prod`];

  static flags = {};

  static args = [];

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(DevModeProd);
    await this.utils.runCoreScript("commands/dev/mode/prod.sh", argv);
  }
}
