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
        if (currentFilteredData && nextFilteredData) {
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
          if (currentFilteredData && nextFilteredData) {
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
    } else {
      console.warn("Aborted. This command only works in cluster context.");
    }
  }
}
