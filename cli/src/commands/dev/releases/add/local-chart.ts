import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../../../base";
// import {Plop, run} from "plop";
// import * as path from 'path';
// const Plop = require('plop')

export default class DevReleasesAddLocalChart extends BaseCommand {
  static description = "Adds a local Helm Chart to kube-core.";

  static examples = [`$ kube-core dev releases add local-chart chart-name`];

  static flags = {};

  static args = [];

  static strict = false;

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(DevReleasesAddLocalChart);
    await this.utils.runCoreScript(
      "commands/dev/releases/add-local-chart.sh",
      argv
    );
  }
}
