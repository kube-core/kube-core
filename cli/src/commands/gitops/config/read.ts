import { Flags } from "@oclif/core";
import BaseCommand from "../../../base";
import * as path from "path";
import YAML from "yaml";

export default class GitopsConfigRead extends BaseCommand {
  static description = "Read your GitOps Config";

  static examples = [
    `# Read all config as yaml
$ kube-core gitops config read
# Read all config as json
$ kube-core gitops config read -o json
# List cluster-wide resources
$ kube-core gitops config read | yq '.items[] | select(.metadata.namespace==null) | (.kind + "/" + .metadata.name)'
# List Deployments
$ kube-core gitops config read -o json | jq '.items[] | select(.kind=="Deployment)'
# List Namespaces
$ kube-core gitops config read '.items[] | select(.kind=="Namespace") | .metadata.name'`,
  ];

  static flags = {
    output: Flags.string({
      char: "o",
      description: "Output format. yaml|json",
      hidden: false,
      multiple: false,
      default: "yaml",
      required: false,
    }),
    query: Flags.string({
      char: "q",
      description:
        "A valid basic jq expression to filter on. If you need to use complex queries or jq args, use -o json instead and pipe to jq yourself.",
      hidden: false,
      multiple: false,
      required: false,
    }),
  };

  static args = [];

  static strict = false;

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(GitopsConfigRead);
    if (this.clusterContext === true) {
      // Reading all GitOps Config
      let configPath = path.join(this.clusterConfigDirPath);
      await this.utils.mkdir(configPath);

      let fullConfig = await this.utils.loadYamlFilesFromPathAsItemsList(
        configPath,
        "config",
        true
      );
      let config = fullConfig;

      // If arg is given
      if (argv.length > 0) {
        const filter = argv.join(" ");
        const jqFilterResult = await this.utils.cliStream("jq", [filter], {
          input: JSON.stringify(config),
          maxBuffer: 300_000_000,
        });
        console.log(jqFilterResult.stdout);
      } else {
        if (flags.output === "yaml") {
          const prettyData = await this.utils.cliStream("yq", [], {
            input: YAML.stringify(config),
            maxBuffer: 300_000_000,
          });
          console.log(prettyData.stdout);
        } else if (flags.output === "json") {
          const prettyData = await this.utils.cliStream("jq", [], {
            input: JSON.stringify(config),
            maxBuffer: 300_000_000,
          });
          console.log(prettyData.stdout);
        }
      }
    } else {
      console.warn("Aborted. This command only works in cluster context.");
    }
  }
}
