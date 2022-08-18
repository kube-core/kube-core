import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../base";

import {
  camelCase,
  capitalCase,
  constantCase,
  dotCase,
  headerCase,
  noCase,
  paramCase,
  pascalCase,
  pathCase,
  sentenceCase,
  snakeCase,
} from "change-case";

export default class ApplyCrds extends BaseCommand {
  static description = "Applies CRDs from kube-core and local cluster CRDs.";

  static examples = [`
    $ kube-core apply:crds
    $ kube-core apply:crds --dry-run
    $ kube-core apply:crds --dry-run=client # client side
    $ kube-core apply:crds --dry-run=server # server side (if applicable)
    $ kube-core apply:crds --filter=velero # Only what matches the filter
  `];

  // static flags = {
  //   args: Flags.string({
  //     description: 'Args passed down to current script', 
  //     env: 'KUBE_CORE_SCRIPT_ARGS',               
  //   }),
  // };

  static args = [];

  static strict = false

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(ApplyCrds);

    const coreCrds = await this.utils.runScript("commands/apply/crds.sh", argv, {});
    const clusterCrds = await this.utils.runScript("src/cluster/apply/crds.sh", argv, {});
  }
}
