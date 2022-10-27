import BaseCommand from "../../../base";
import * as upath from "upath";
import * as fs from 'fs-extra'
import { Flags } from "@oclif/core";

const { lookpath } = require('lookpath');

export default class GitopsConfigIndex extends BaseCommand {
  static description = "Index your GitOps config, required for gitops config diff"

  static examples = [`# Build your index when git workspace is clean. This generates: ./data/full.js
$ kube-core gitops config index
# Make some changes
$ ...
# Build your new config
$ kube-core build all
# Build your next index. This generates: ./data/next-full.js
$ kube-core gitops config index
# Force refresh example
$ git stash && kube-core gitops config index --rebuild-current
$ git stash apply && kube-core build all && gitops config index --rebuild-next`];

  static flags = {
    rebuildNext: Flags.boolean({
      description: 'Force rebuild next index',
      hidden: false,
      required: false,
      default: false
    }),
    rebuildCurrent: Flags.boolean({
      description: 'Force rebuild current index',
      hidden: false,
      required: false,
      default: false
    }),
  }

  static args = [];

  static strict = false

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(GitopsConfigIndex);
    if (this.clusterContext === true) {
        const gron = await lookpath('gron');
        if (gron === undefined) {
          console.error('Please install gron on your system and make it available to your path. https://github.com/tomnomnom/gron')
          process.exit(0)
        }
        let configPath = upath.join(this.clusterConfigDirPath)
        await this.utils.mkdir(configPath)

        
        if(this.gitopsConfigHasChanges === true || flags.rebuildNext === true) {
          // Rebuild Next 
          let dataPath = upath.join(this.clusterConfigDirPath, "data")
          let indexPath = upath.join(dataPath, "next-full.js")
          if (!this.utils.fileExists(indexPath) || flags.rebuildNext === true)  {
            // Loading Config
            let fullConfig = await this.utils.loadYamlFilesFromPathAsDataObject(configPath, "config")
            let config = fullConfig
            let jsonConfig = JSON.stringify(config)
            const data = await this.utils.cliStream('gron', [], {input: jsonConfig, maxBuffer: 300_000_000})
            await this.utils.mkdir(dataPath)
            await fs.writeFile(indexPath, data.stdout)
            console.log(`Index built at: ${indexPath}`)
          } else {
            console.log("Next index already exists. Use --rebuild-next")
          }
        } else if (this.gitopsConfigHasChanges == false|| flags.rebuildCurrent === true) {
          // Rebuild Current
          let dataPath = upath.join(this.clusterConfigDirPath, "data")
          let indexPath = upath.join(dataPath, "full.js")
          if (!this.utils.fileExists(indexPath) || flags.rebuildCurrent === true)  {
            // Loading Config
            let fullConfig = await this.utils.loadYamlFilesFromPathAsDataObject(configPath, "config")
            let config = fullConfig
            let jsonConfig = JSON.stringify(config)
            const data = await this.utils.cliStream('gron', [], {input: jsonConfig, maxBuffer: 300_000_000})
            await this.utils.mkdir(dataPath)
            await fs.writeFile(indexPath, data.stdout)
            console.log(`Index built at: ${indexPath}`)
          } else {
            console.log("Next index already exists. Use --rebuild-current")
          }
        }
    } else {
      console.warn('Aborted. This command only works in cluster context.')
    }
  }
}
