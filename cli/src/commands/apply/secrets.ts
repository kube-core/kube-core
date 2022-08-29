import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../base";

export default class ApplySecrets extends BaseCommand {
  static description = "Applies all Secrets.";

  static examples = [`
    $ kube-core apply:secrets
    $ kube-core apply:secrets --dry-run
  `];

  static flags = {};

  static args = [];

  static strict = false

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(ApplySecrets);

    console.log("Applying local cluster secrets (if any)")
    const clusterSecrets = await this.utils.runClusterScript("src/cluster/apply/secrets.sh", argv);
    console.log("Done applying local cluster secrets!")
  }
}
