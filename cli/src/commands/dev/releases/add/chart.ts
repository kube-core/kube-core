import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../../../base";
// import {Plop, run} from "plop";
// import * as path from 'path';
// const Plop = require('plop')

export default class DevReleasesAddChart extends BaseCommand {
  static description = "Adds a Helm Chart to kube-core.";

  static examples = [`$ kube-core dev releases add chart helm-repository chart-name chart-version`];

  static flags = {};

  static args = [];

  static strict = false;

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(DevReleasesAddChart);
    await this.utils.runCoreScript("commands/dev/releases/add-chart.sh", argv);
  }
}
