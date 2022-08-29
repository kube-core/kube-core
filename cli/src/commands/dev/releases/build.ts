import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../../base";

export default class DevReleasesBuild extends BaseCommand {
  static description = "Builds kube-core releases distribution.";

  static examples = [`
  $ kube-core dev:releases:build # Builds all Releases
  $ kube-core dev:releases:build tekton # Builds everything that matches the filter (grep)
  `];

  static flags = {};

  static args = [];

  static strict = false;

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(DevReleasesBuild);
    await this.utils.runCoreScript("commands/dev/releases/run.sh", argv);
  }
}
