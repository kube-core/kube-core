import BaseCommand from "../../../base";
import * as upath from "path";
const { lookpath } = require("lookpath");
import * as fs from "fs-extra";

export default class GitopsConfigSearch extends BaseCommand {
  static description = "Search your GitOps Config";

  static examples = [
    `# Search by path in config
$ kube-core-dev gitops config search /config/velero/deployment
$ kube-core-dev gitops config search velero/deployment
$ kube-core-dev gitops config search deployment/velero
# Search any term. Get all matches in every resource, with partial context.
$ kube-core-dev gitops config search root
# Stream all resources line by line. You do the search!
$ kube-core-dev gitops config search
# Custom search: find any reference of "nginx" in deployments and spec.containers
$ kube-core-dev gitops config search | grep /deployment | grep spec.containers | grep nginx
# Make your search results human readable
$ kube-core-dev gitops config search | grep /deployment | grep spec.containers | grep nginx | gron --ungron | yq -P -C
# Hilight your matches
$ kube-core-dev gitops config search | grep /deployment | grep spec.containers | grep nginx | gron --ungron | yq -P -C | grep --color=always -E 'nginx|$'`,
  ];

  static flags = {};

  static args = [];

  static strict = false;

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(GitopsConfigSearch);
    if (this.clusterContext === true) {
      let dataPath = upath.join(this.clusterConfigDirPath, "data");
      let current = upath.join(dataPath, "full.js");
      let next = upath.join(dataPath, "next-full.js");
      let data;

      if (!this.gitopsConfigHasChanges && this.utils.fileExists(current)) {
        data = await fs.readFile(current, "utf8");
        // console.log(data)
      } else if (this.gitopsConfigHasChanges && this.utils.fileExists(next)) {
        data = await fs.readFile(next, "utf8");
        // console.log(data)
      } else {
        // TODO: Make search more efficient (full document search, search/replace?, ES integration?)
        let fullConfig = await this.utils.loadYamlFilesFromPathAsDataObject(
          this.clusterConfigDirPath,
          "config"
        );
        // Probably a better alternative, but impossible to grep on path (TODO: need to implement path label on every resource)
        // let fullConfig = await this.utils.loadYamlFilesFromPathAsItemsList(this.clusterConfigDirPath, "config")
        let config = fullConfig;
        let jsonConfig = JSON.stringify(config);
        data = await this.utils.cliStream("gron", [], {
          input: jsonConfig,
          maxBuffer: 300_000_000,
        });
        if (data.stdout) {
          data = data.stdout;
        }
      }
      let filter = "";
      if (argv[0]) {
        filter = argv[0];

        const filteredData = await this.utils.cliStream("grep", [filter], {
          input: data,
          maxBuffer: 300_000_000,
        });
        // console.log(filteredData.stdout)

        const reconstructedData = await this.utils.cliStream(
          "gron",
          ["--ungron"],
          { input: filteredData.stdout, maxBuffer: 300_000_000 }
        );
        // console.log(reconstructedData.stdout)

        const prettyData = await this.utils.cliStream("yq", ["-P", "-C"], {
          input: reconstructedData.stdout,
          maxBuffer: 300_000_000,
        });
        console.log(prettyData.stdout);

        const hilighted = await this.utils.cliStream(
          "grep",
          ["--color=always", "-E", `'${filter}|$'`],
          { input: prettyData.stdout, maxBuffer: 300_000_000 }
        );
        console.log(hilighted.stdout);
      } else {
        console.log("test");
        console.log(data);
      }
    } else {
      console.warn("Aborted. This command only works in cluster context.");
    }
  }
}
