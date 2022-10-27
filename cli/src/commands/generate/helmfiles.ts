import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../base";
import upath from "upath";
import * as fs from 'fs-extra'
export default class GenerateHelmfiles extends BaseCommand {
  static description = "Generate helmfiles to setup your project quickly";

  static examples = [`# Generate "quickstart" helmfiles 
$ kube-core generate helmfiles --quickstart
# Generate "classic" helmfiles (inte,valid,preprod,prod)
$ kube-core generate helmfiles --classic
`];

  static flags = {
    quickstart: Flags.boolean({
      description: 'Generate everything to get started',
      hidden: false,
      required: false
    }),
    classic: Flags.boolean({
      description: 'Generate environments: integration, validation, preproduction, production',
      hidden: false,
      required: false
    }),
  }

  static args = [];

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(GenerateHelmfiles);
    
    const localDir = upath.join(this.clusterConfigDirPath, "helmfiles")
    
    let files    
    if (flags.quickstart === true) {
      files = await this.utils.getFilesAsList(upath.join(this.corePath, "core/templates/generate/quickstart"))
      for(let file of files) {
        let {name, ext} = upath.parse(file)
        let targetPath = upath.join(localDir, `${name}${ext}`)
        let fileData = await fs.readFile(file, "utf8")
        fileData = fileData.replace("KUBE_CORE_CLUSTER_CONFIG_CONTEXT", this.clusterConfig.cluster.config.context)
        await this.utils.mkdir(upath.parse(targetPath).dir)
        await fs.writeFile(targetPath, fileData)
      }
    } else if (flags.classic) {
      files = await this.utils.getFilesAsList(upath.join(this.corePath, "core/templates/generate/classic"))
      for(let file of files) {
        let {name, ext} = upath.parse(file)
        let targetPath = upath.join(localDir, `${name}${ext}`)
        let fileData = await fs.readFile(file, "utf8")
        fileData = fileData.replace("KUBE_CORE_CLUSTER_CONFIG_CONTEXT", this.clusterConfig.cluster.config.context)
        await this.utils.mkdir(upath.parse(targetPath).dir)
        await fs.writeFile(targetPath, fileData)
      }
    } else {
      console.warn('Use --quickstart or --classic flags')
    }
  }
}
