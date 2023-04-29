import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../../../base";

export default class ClusterSetupTektonSoftwareFactory extends BaseCommand {
  static description = "Setup local configuration and secrets to use Tekton with Software Factory tools";

  static examples = [`$ kube-core cluster setup tekton software-factory`];

  static flags = {};

  static args = [];

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(ClusterSetupTektonSoftwareFactory);
    await this.utils.runClusterScript("src/cloud/gcp/setup/tekton/sf.sh", argv);
  }
}
