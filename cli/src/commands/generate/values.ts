import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../base";
import upath from "upath";
import YAML from "yaml";
import * as fs from "fs-extra";
import merge from "lodash.merge";
export default class GenerateValues extends BaseCommand {
  static description =
    "Quickly generate layers from the core and merges with your local config if already existing";

  static examples = [`$ kube-core generate values`];

  static flags = {};

  static args = [];

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(GenerateValues);
    // await this.utils.runCoreScript("commands/generate/values.sh", argv);

    // Getting layers from core
    let releaseFiles = await this.utils.getFilesAsList(
      upath.join(this.corePath, "core/layers/releases")
    );
    let configFiles = await this.utils.getFilesAsList(
      upath.join(this.corePath, "core/layers/config")
    );
    // console.log(files)

    const localConfigDir = upath.join(this.clusterConfigDirPath, "values");

    for (let file of configFiles) {
      let { name, ext } = upath.parse(file);
      let targetPath = upath.join(
        localConfigDir,
        "core/config",
        `${name}${ext}`
      );
      let coreFileData = YAML.parse(await fs.readFile(file, "utf8"));
      let mergedData = {};

      // If layer exists locally, we merge both
      if (this.utils.fileExists(targetPath)) {
        // console.log(`File exists: ${targetPath}`)
        let currentFileData = YAML.parse(await fs.readFile(targetPath, "utf8"));
        console.info(
          `Merging: kube-core:${file.replace(
            this.corePath,
            ""
          )}\t<- local:${targetPath.replace(this.clusterConfigDirPath, "")}`
        );
        mergedData = merge(coreFileData, currentFileData);
        // console.log(mergedData)
      } else {
        mergedData = coreFileData;
      }
      await this.utils.mkdir(upath.parse(targetPath).dir);
      await fs.writeFile(targetPath, YAML.stringify(mergedData));
    }

    for (let file of releaseFiles) {
      let { name, ext } = upath.parse(file);
      let targetPath = upath.join(
        localConfigDir,
        "core/releases",
        `${name}${ext}`
      );
      let coreFileData = YAML.parse(await fs.readFile(file, "utf8"));
      let mergedData = {};

      // If layer exists locally, we merge both
      if (this.utils.fileExists(targetPath)) {
        // console.log(`File exists: ${targetPath}`)
        let currentFileData = YAML.parse(await fs.readFile(targetPath, "utf8"));
        console.info(
          `Merging: kube-core:${file.replace(
            this.corePath,
            ""
          )}\t<- local:${targetPath.replace(this.clusterConfigDirPath, "")}`
        );
        mergedData = merge(coreFileData, currentFileData);
        // console.log(mergedData)
      } else {
        mergedData = coreFileData;
      }
      await this.utils.mkdir(upath.parse(targetPath).dir);
      await fs.writeFile(targetPath, YAML.stringify(mergedData));
    }
  }
}
