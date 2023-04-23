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

  static flags = {
    base: Flags.boolean({
      description:
        "Generates core, cluster and local helmfiles to allow using kube-core platform. Enabled by default. Use --no-core to disable.",
      hidden: false,
      required: false,
      allowNo: true,
      default: false,
    }),
    full: Flags.boolean({
      description:
        "Generates core, cluster and local helmfiles to allow using kube-core platform. Enabled by default. Use --no-core to disable.",
      hidden: false,
      required: false,
      allowNo: true,
      default: false,
    }),
    quickstart: Flags.boolean({
      description:
        "Generates core, cluster and local helmfiles to allow using kube-core platform. Enabled by default. Use --no-core to disable.",
      hidden: false,
      required: false,
      allowNo: true,
      default: false,
    }),
    envs: Flags.boolean({
      description:
        "Generates core, cluster and local helmfiles to allow using kube-core platform. Enabled by default. Use --no-core to disable.",
      hidden: false,
      required: false,
      allowNo: true,
      default: false,
    }),
  };

  static args = [];

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(GenerateValues);
    // await this.utils.runCoreScript("commands/generate/values.sh", argv);

    let layersTemplate = "core/layers/base"

    if (flags.quickstart === true) {
      layersTemplate = "core/layers/quickstart"
    }

    await this.mergeCoreLayersWithLocalLayers(`${layersTemplate}/values/cluster/config`, `cluster/config`);
    await this.mergeCoreLayersWithLocalLayers(`${layersTemplate}/values/cluster/releases`, `cluster/releases`);

    await this.mergeCoreLayersWithLocalLayers(`${layersTemplate}/values/core/cluster`, `core/cluster`);
    await this.mergeCoreLayersWithLocalLayers(`${layersTemplate}/values/core/config`, `core/config`);
    await this.mergeCoreLayersWithLocalLayers(`${layersTemplate}/values/core/releases`, `core/releases`);

    await this.mergeCoreLayersWithLocalLayers(`${layersTemplate}/values/platform/config`, `platform/config`);
    await this.mergeCoreLayersWithLocalLayers(`${layersTemplate}/values/platform/environments`, `platform/environments`);
    await this.mergeCoreLayersWithLocalLayers(`${layersTemplate}/values/platform/applications`, `platform/applications`);
    await this.mergeCoreLayersWithLocalLayers(`${layersTemplate}/values/platform/services`, `platform/services`);

    await this.mergeCoreLayersWithLocalLayers(`${layersTemplate}/values/envs/default/applications`, `envs/default/applications`);
    await this.mergeCoreLayersWithLocalLayers(`${layersTemplate}/values/envs/default/services`, `envs/default/services`);

    await this.mergeCoreLayersWithLocalLayers(`${layersTemplate}/values/envs/dev/applications`, `envs/dev/applications`);
    await this.mergeCoreLayersWithLocalLayers(`${layersTemplate}/values/envs/dev/services`, `envs/dev/services`);

  }


  async mergeCoreLayersWithLocalLayers(sourceFolder, targetFolder) {

    // Getting layers from core
    let configFiles = await this.utils.getFilesAsList(
      upath.join(this.corePath, sourceFolder)
    );


    const localConfigDir = upath.join(this.clusterConfigDirPath, "values");
    const localValuesPath = this.valuesPath

    for (let file of configFiles) {
      let { name, ext } = upath.parse(file);
      let targetPath = upath.join(
        localConfigDir,
        targetFolder,
        `${name}${ext}`
      );
      let coreFileData
      if (ext === ".yaml" && name !== "schema") {
        coreFileData = YAML.parse(await fs.readFile(file, "utf8"));
      } else if (ext === ".gotmpl" || name == "schema") {
        coreFileData = await fs.readFile(file, "utf8")
      }
      let mergedData = {};

      // If layer exists locally, we merge both
      if (this.utils.fileExists(targetPath)) {
        // console.log(`File exists: ${targetPath}`)

        if(ext === ".yaml" && name !== "schema") {
          let currentFileData = YAML.parse(await fs.readFile(targetPath, "utf8"));
          console.info(
            `Merging: kube-core:${file.replace(
              this.corePath,
              ""
              )}\t<- local:${targetPath.replace(this.clusterConfigDirPath, "")}`
              );
              mergedData = merge(coreFileData, currentFileData);
              // console.log(mergedData)
        } else if (ext === ".gotmpl" || name == "schema") {
          let currentFileData = await fs.readFile(targetPath, "utf8")
          console.info(
            `Copying: kube-core:${file.replace(
              this.corePath,
              ""
              )}\t<- local:${targetPath.replace(this.clusterConfigDirPath, "")}`
              );
          mergedData = currentFileData
        }
      } else {
        mergedData = coreFileData;
      }
      await this.utils.mkdir(upath.parse(targetPath).dir);
      if(ext === ".yaml" && name !== "schema") {
        await fs.writeFile(targetPath, YAML.stringify(mergedData))
      } else if (ext === ".gotmpl" || name == "schema") {
        await fs.writeFile(targetPath, mergedData)
      }
    }

  }


}
