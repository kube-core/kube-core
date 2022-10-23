import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../../base";

export default class DevReleasesBuild extends BaseCommand {
  static description = "Builds kube-core dist";

  static examples = [`# Build all Releases
$ kube-core dev releases build
# Build everything that matches the filter (grep)
$ kube-core dev releases build tekton`];

  static flags = {};

  static args = [];

  static strict = false;

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(DevReleasesBuild);
    await this.utils.runCoreScript("commands/dev/releases/run.sh", argv);
  }
}
