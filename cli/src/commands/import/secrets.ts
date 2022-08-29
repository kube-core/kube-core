import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../base";

export default class ImportSecrets extends BaseCommand {
  static description = "Imports secrets from a namespace in the cluster to local manifests.";

  static examples = [`
  $ kube-core import:secrets namespace # All Secrets in the Namespace
  $ kube-core import:secrets namespace filter # Secrets with a name that matches the filter
  `];

  static flags = {};

  static args = [];

  static strict = false
  
  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(ImportSecrets);
    await this.utils.runClusterScript("src/k8s/secrets/import-secrets.sh", argv);
  }
}
