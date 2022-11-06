import BaseCommand from "../../../base";
import * as path from "path";
import * as upath from "upath";
import * as fs from "fs-extra";
import { Flags } from "@oclif/core";

export default class GitopsConfigSearch extends BaseCommand {
  static description = "Search your GitOps Config";

  static examples = [
    `# Global gitops diff
$ kube-core gitops config diff
# Chain include and exclude
$ kube-core gitops config diff --include secret --exclude "rabbitmq|mongodb"
# Advanced diff, using include, exclude and filter
$ kube-core gitops config diff --include "preproduction|production" --exclude namespace --filter='select(to_entries | length > 0) | to_entries | . | map({(.key): {"labels":.value.metadata.labels}}) | add'`,
  ];

  static flags = {
    include: Flags.string({
      description: "Grep filter",
      hidden: false,
      required: false,
    }),
    exclude: Flags.string({
      description: "Grep filter",
      hidden: false,
      required: false,
    }),
    filter: Flags.string({
      description: "jq filter that will be used to prepare before diff",
      hidden: false,
      required: false,
    }),
  };

  static args = [];

  static strict = false;

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(GitopsConfigSearch);
    if (this.clusterContext === true) {
      let configPath = path.join(this.clusterConfigDirPath);
      await this.utils.mkdir(configPath);

      let dataPath = upath.join(this.clusterConfigDirPath, "data");
      let currentIndexPath = upath.join(dataPath, "full.js");
      let nextIndexPath = upath.join(dataPath, "next-full.js");

      if (!(await this.utils.fileExists(currentIndexPath))) {
        console.warn(
          `Current index is missing. Follow these instructions: kube-core gitops config index --help`
        );
        return;
      }

      if (!(await this.utils.fileExists(nextIndexPath))) {
        console.warn(
          `Next index is missing. Follow these instructions: kube-core gitops config index --help`
        );
        return;
      }
      let currentFilteredIndexPath = upath.join(dataPath, "full-filtered.js");
      let nextFilteredIndexPath = upath.join(dataPath, "next-full-filtered.js");

      let current = currentIndexPath;
      let next = nextIndexPath;

      let currentFilteredData;
      let nextFilteredData;
      let ungronCurrentFilteredData;
      let ungronNextFilteredData;
      let jqCurrentFilteredData;
      let jqNextFilteredData;
      let regronCurrentFilteredData;
      let regronNextFilteredData;

      // --include
      if (flags.include) {
        currentFilteredData = await this.utils.cliStream(
          "grep",
          ["-E", flags.include, `${currentIndexPath}`],
          { maxBuffer: 900_000_000 }
        );
        nextFilteredData = await this.utils.cliStream(
          "grep",
          ["-E", flags.include, `${nextIndexPath}`],
          { maxBuffer: 900_000_000 }
        );
      }

      // --exclude
      if (flags.exclude) {
        if (currentFilteredData.stdout && nextFilteredData.stdout) {
          currentFilteredData = await this.utils.cliStream(
            "grep",
            ["-vE", flags.exclude],
            { input: currentFilteredData.stdout, maxBuffer: 900_000_000 }
          );
          nextFilteredData = await this.utils.cliStream(
            "grep",
            ["-vE", flags.exclude],
            { input: nextFilteredData.stdout, maxBuffer: 900_000_000 }
          );
        } else {
          currentFilteredData = await this.utils.cliStream(
            "grep",
            ["-vE", flags.exclude, `${currentIndexPath}`],
            { maxBuffer: 900_000_000 }
          );
          nextFilteredData = await this.utils.cliStream(
            "grep",
            ["-vE", flags.exclude, `${nextIndexPath}`],
            { maxBuffer: 900_000_000 }
          );
        }
      }
      // --filter
      if (flags.filter) {
        let currentInput;
        let nextInput;

        // Check if we already filtered with include or exclude
        if (currentFilteredData) {
          if (currentFilteredData.stdout && nextFilteredData.stdout) {
            currentInput = currentFilteredData.stdout;
            nextInput = nextFilteredData.stdout;
          }
        } else {
          currentInput = await fs.readFile(currentIndexPath);
          nextInput = await fs.readFile(nextIndexPath);
        }

        // Ungron config
        ungronCurrentFilteredData = await this.utils.cliStream(
          "gron",
          ["--ungron"],
          { input: currentInput, maxBuffer: 900_000_000 }
        );
        ungronNextFilteredData = await this.utils.cliStream(
          "gron",
          ["--ungron"],
          { input: nextInput, maxBuffer: 900_000_000 }
        );

        // Run jq filter
        jqCurrentFilteredData = await this.utils.cliStream(
          "jq",
          [flags.filter],
          { input: ungronCurrentFilteredData.stdout, maxBuffer: 900_000_000 }
        );
        jqNextFilteredData = await this.utils.cliStream("jq", [flags.filter], {
          input: ungronNextFilteredData.stdout,
          maxBuffer: 900_000_000,
        });

        // console.log(jqCurrentFilteredData.stdout)
        // process.exit()

        // Regron config
        regronCurrentFilteredData = await this.utils.cliStream("gron", [], {
          input: jqCurrentFilteredData.stdout,
          maxBuffer: 900_000_000,
        });
        regronNextFilteredData = await this.utils.cliStream("gron", [], {
          input: jqNextFilteredData.stdout,
          maxBuffer: 900_000_000,
        });
      }

      let currentData;
      let nextData;

      if (
        regronCurrentFilteredData &&
        regronNextFilteredData &&
        currentFilteredData &&
        nextFilteredData
      ) {
        currentData = regronCurrentFilteredData.stdout;
        nextData = regronNextFilteredData.stdout;
        current = currentFilteredIndexPath;
        next = nextFilteredIndexPath;
      } else if (currentFilteredData && nextFilteredData) {
        currentData = currentFilteredData.stdout;
        nextData = nextFilteredData.stdout;
        current = currentFilteredIndexPath;
        next = nextFilteredIndexPath;
      }

      if (
        current &&
        currentData &&
        next &&
        nextData &&
        current !== currentIndexPath &&
        next !== nextIndexPath
      ) {
        await fs.writeFile(current, currentData);
        await fs.writeFile(next, nextData);
      }

      // const diffData = await this.utils.cliStream('diff', [`${next}`, `${current}`], {maxBuffer: 900_000_000, reject: false})
      const diffData = await this.utils.cliStream(
        "diff",
        [`--color=always`, `${next}`, `${current}`],
        { maxBuffer: 900_000_000, reject: false }
      );
      console.log(diffData.stdout);
      if (diffData.stdout) {
        await fs.writeFile(upath.join(dataPath, "last.diff"), diffData.stdout);
      } else {
        // No diff
      }

      // const diffData = await this.utils.cliStream('diff', ["--color=always", `${next}`, `${current}`], {maxBuffer: 900_000_000, reject: false})
      // console.log(diffData.stdout)

      // let configHasChanges = false
      // const data = await this.utils.cliStream('git', ["status", "--porcelain", path.join(this.clusterConfigDirPath, "config")], {maxBuffer: 300_000_000})
      // if (data.stdout != "") {
      //   configHasChanges = true
      // }

      // if(configHasChanges === true) {
      //   let dataPath = upath.join(this.clusterConfigDirPath, "data")
      //   let indexPath = upath.join(dataPath, "next-full.js")
      //   if (!this.utils.fileExists(indexPath) || flags.rebuildNext === true)  {
      //     const data = await this.utils.cliStream('gron', [], {input: jsonConfig, maxBuffer: 300_000_000})
      //     await this.utils.mkdir(dataPath)
      //     await fs.writeFile(indexPath, data.stdout)
      //   }
      // } else if (configHasChanges == false) {
      //   let dataPath = upath.join(this.clusterConfigDirPath, "data")
      //   let indexPath = upath.join(dataPath, "full.js")
      //   if (!this.utils.fileExists(indexPath) || flags.rebuildCurrent === true)  {
      //     const data = await this.utils.cliStream('gron', [], {input: jsonConfig, maxBuffer: 300_000_000})
      //     await this.utils.mkdir(dataPath)
      //     await fs.writeFile(indexPath, data.stdout)
      //   }
      // }
      // ---
      // for (let item of Object.entries(config)) {
      //     let itemPath = item[0]
      //     let itemData = item[1]

      //     // Current Resource
      //     const data = await this.utils.cliStream('jq', [`{"${itemPath}": .}`], {input: JSON.stringify(itemData), maxBuffer: 300_000_000})
      //     // console.log(data.stdout)

      //     const gronData = await this.utils.cliStream('gron', [], {input: data.stdout, maxBuffer: 300_000_000})
      //     // console.log(gronData.stdout)

      //     // Resource from last revision
      //     const lastItemData = await this.utils.cliStream('git', ['--no-pager', 'show', `HEAD~1:cluster${itemPath}`], {maxBuffer: 300_000_000})
      //     // console.log(lastItemData.stdout)

      //     const lastItemJsonData = await this.utils.cliStream('yq', [`{"${itemPath}": .}`, '-o', 'json'], {input: lastItemData.stdout, maxBuffer: 300_000_000})
      //     // console.log(lastItemJsonData.stdout)

      //     const lastItemGronData = await this.utils.cliStream('gron', [], {input: lastItemJsonData.stdout, maxBuffer: 300_000_000})
      //     console.log(lastItemGronData.stdout)

      //     // const diffData = await this.utils.cliStream('diff', [`<(echo "test")`, `<(echo "blabla")`], {maxBuffer: 300_000_000})
      //     let diffData

      //     // diffData = gitDiff("test", "test2")
      //     // console.log(diffData)

      //     // diffData = gitDiff(gronData.stdout, lastItemGronData.stdout, {forceFake: true})
      //     // console.log(diffData)

      //     // process.exit()
      // }
      // //
      // let jsonConfig = JSON.stringify(config)
      // const data = await this.utils.cliStream('gron', [], {input: jsonConfig, maxBuffer: 300_000_000})

      // let filter = ""
      // if (argv[0]) {
      //   filter = argv[0]

      //   const filteredData = await this.utils.cliStream('grep', [filter], {input: data.stdout, maxBuffer: 300_000_000})
      //   // console.log(filteredData.stdout)

      //   const reconstructedData = await this.utils.cliStream('gron', ["--ungron"], {input: filteredData.stdout, maxBuffer: 300_000_000})
      //   // console.log(reconstructedData.stdout)

      //   const prettyData = await this.utils.cliStream('yq', ["-P", "-C"], {input: reconstructedData.stdout, maxBuffer: 300_000_000})
      //   console.log(prettyData.stdout)

      //   const hilighted = await this.utils.cliStream('grep', ["--color=always", "-E", `'${filter}|$'`], {input: prettyData.stdout, maxBuffer: 300_000_000})
      //   console.log(hilighted.stdout)
      // } else {
      //   console.log(data.stdout)
      // }
      // ----

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
