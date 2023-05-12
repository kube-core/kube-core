import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../../base";

export default class DevReleasesUpdate extends BaseCommand {
  static description = "Builds kube-core dist";

  static examples = [`$ kube-core dev releases update`];

  static flags = {};

  static args = [];

  static strict = false;

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(DevReleasesUpdate);
    await this.utils.runCoreScript("commands/dev/releases/update-releases.sh", argv);
  }
}
