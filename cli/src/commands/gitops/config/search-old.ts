import BaseCommand from "../../../base";
import * as path from "path";
const { lookpath } = require("lookpath");

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
      const gron = await lookpath("gron");
      if (gron === undefined) {
        console.error(
          "Please install gron on your system and make it available to your path. https://github.com/tomnomnom/gron"
        );
        process.exit(0);
      }
      let configPath = path.join(this.clusterConfigDirPath);
      await this.utils.mkdir(configPath);

      // TODO: Make search more efficient (full document search, search/replace?, ES integration?)
      let fullConfig = await this.utils.loadYamlFilesFromPathAsDataObject(
        configPath,
        "config"
      );
      // Probably a better alternative, but impossible to grep on path (TODO: need to implement path label on every resource)
      // let fullConfig = await this.utils.loadYamlFilesFromPathAsItemsList(configPath, "config")
      let config = fullConfig;
      let jsonConfig = JSON.stringify(config);
      const data = await this.utils.cliStream("gron", [], {
        input: jsonConfig,
        maxBuffer: 300_000_000,
      });

      let filter = "";
      if (argv[0]) {
        filter = argv[0];

        const filteredData = await this.utils.cliStream("grep", [filter], {
          input: data.stdout,
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
        console.log(data.stdout);
      }

      // let parsedData = JSON.parse(reconstructedData.stdout)

      // let results = []
      // for (let doc of Object.entries(parsedData)) {
      //   for (let value of doc) {
      //     if (typeof value === 'object'){
      //       results.push(value)
      //     }
      //   }
      // }
      // console.log(JSON.stringify(results, null, 2))

      // for(let resource of config.items)  {
      //   let jsonConfig = JSON.stringify(resource)
      //   const data = await this.utils.cliStream('gron', [], {input: jsonConfig, maxBuffer: 300_000_000})
      //   console.log(data)
      //   break
      // }
      //   let jsonConfig = JSON.stringify(resource)
      // //   // const result = await this.utils.cliStream('ls', {}, {maxBuffer: 300_000_000, input: '{"data":"test"}'})
      //       const data = this.utils.cliStream('gron', [], {input: '{"data": "test"}', maxBuffer: 300_000_000})
      // //   // console.log(output.stdout)
      // }

      // let items = config.items.map(item => `${item.metadata.name}`).filter(item => typeof item === 'string')
      // console.log(namespaces)
      // let matches = this.utils.fuzzySearch(items, "velero")
      // console.log(matches)

      // console.log(jsonConfig)
      // const result = await this.utils.cliStream('gron', {}, {maxBuffer: 300_000_000, input: jsonConfig})
      // console.log(result.stdout)

      // const result = await this.utils.cliStreap('gron', {}, )
      // console.log(result.stdout)
      // process.stdin.write('input to be made into a docx file')
      // process.stdin.end();
      // const result = await process

      // // Reading all GitOps Config
      // let configPath = path.join(this.clusterConfigDirPath)
      // await this.utils.mkdir(configPath)

      // let fullConfig = await this.utils.loadYamlFilesFromPathAsItemsList(configPath, "config", true)
      // let config = fullConfig

      // // If arg is given
      // if (argv.length > 0) {
      //   const filter = argv.join(" ")
      //   const options = { input: 'json' }
      //   const jqFilterResult = await this.utils.jq(filter, fullConfig, options)
      //   console.log(jqFilterResult)
      // } else {
      //   if(flags.output === "yaml") {
      //     console.log(dumpYaml(config))
      //   } else if (flags.output === "json") {
      //     console.log(JSON.stringify(config))
      //   }
      // }
    } else {
      console.warn("Aborted. This command only works in cluster context.");
    }
  }
}
