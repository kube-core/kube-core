import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../../../base";
// import {Plop, run} from "plop";
// import * as path from 'path';
// const Plop = require('plop')

export default class DevReleasesAddRelease extends BaseCommand {
  static description = "Adds a Helmfile Release to kube-core.";

  static examples = [
    `$ kube-core dev releases add release chart-name release-name namespace`,
  ];

  static flags = {};

  static args = [];

  static strict = false;

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(DevReleasesAddRelease);
    await this.utils.runCoreScript(
      "commands/dev/releases/add-release.sh",
      argv
    );
  }
}
