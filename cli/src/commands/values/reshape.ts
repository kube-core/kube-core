import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../base";

export default class ValuesReshape extends BaseCommand {
  static description = "Reshape values";

  static examples = [`$ kube-core values reshape`];

  static flags = {
    mode: Flags.string({
      description: "The type of reshaping that will occur.",
      hidden: false,
      required: false,
      default: "all",
      options: ["all", "keys", "deep", "releases", "environments", "custom"]
    }),
    deepFilterKeys: Flags.string({
      description: "Controls which keys will be deeply split (one level)",
      hidden: false,
      required: false,
      default: "cluster|environments|releases",
    }),
    releaseDimensions: Flags.string({
      description: "Controls which dimensions will be added to split the releases",
      hidden: false,
      required: false,
      default: "cloud|config|customExtensions|dynamicSecrets|external-secrets|extraReleaseValues|hooks|ingress|jsonPatches|labels|manifests|monitoring|options|patches|scaling|scheduling|secrets|slack|slos|strategicMergePatches|values",
    }),
  };

  static args = [];

  static strict = false;

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(ValuesReshape);
    // if (this.gitHasChanges) {
    //   this.log('Cannot reshape config with dirty git workspace.')
    // }
    await this.utils.runCoreScript("commands/values/reshape.sh", [flags.mode, flags.deepFilterKeys, flags.releaseDimensions]);
  }
}
