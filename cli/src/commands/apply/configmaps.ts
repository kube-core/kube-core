import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../base";

export default class ApplyConfigMaps extends BaseCommand {
  static description = "Applies all local ConfigMaps.";

  static examples = [`
    $ kube-core apply:configmaps
    $ kube-core apply:configmaps --dry-run
  `];

  static flags = {};

  static args = [];

  static strict = false

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(ApplyConfigMaps);

    console.log("Applying local cluster configmaps (if any)")
    const clusterConfigMaps = await this.utils.runClusterScript("src/cluster/apply/configmaps.sh", argv);
    console.log("Done applying local cluster configmaps!")
  }
}
