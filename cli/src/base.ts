import { Command, Flags } from "@oclif/core";
import path from "path";
import yaml from "js-yaml";
import * as utils from "./lib/utils";
import findUp from 'find-up';
import * as fs from 'fs-extra'


export default abstract class extends Command {
  public utils;
  public scriptsPath;
  public clusterContext
  public clusterConfig
  public clusterConfigPath
  public clusterConfigDirPath

  static flags = {
    // name: Flags.string({
    //   char: 'n',                    // shorter flag version
    //   description: 'namespace to use', // help description for flag
    //   hidden: false,                // hide from help
    //   multiple: false,              // allow setting this flag multiple times
    //   default: 'default',             // default value if flag not passed (can be a function that returns a string or undefined)
    //   required: false,              // make flag required (this is not common and you should probably use an argument instead)
    // }),

    // // flag with no value (-f, --force)
    // force: Flags.boolean({
    //   char: 'f',
    //   default: true,                // default value if flag not passed (can be a function that returns a boolean)
    //   // boolean flags may be reversed with `--no-` (in this case: `--no-force`).
    //   // The flag will be set to false if reversed. This functionality
    //   // is disabled by default, to enable it:
    //   // allowNo: true
    // }),



  }

  async init() {
    this.utils = utils;
    this.scriptsPath = `${path.resolve(`${require.main.filename}/../../scripts`)}`;
    let scriptPath = `${path.join(this.scriptsPath, "src/utils/read-core-path.sh")}`;
    let defaultClusterConfigPath = path.join(this.scriptsPath, "default-cluster-config.yaml")
    let file = 'cluster-config.yaml'

    // let corePath = await this.utils.cliQuiet(scriptPath);
    // let clusterConfigPath = `${path.join(this.corePath, "src/utils/read-core-path.sh")}`

    const foundPath = await findUp(file)
    if (!foundPath) {
      this.clusterContext = false
      // throw new Error(`${file} not found, searching "upwards" from ${process.cwd()}`)
    } else {

      this.clusterContext = true
      let clusterConfigPath = foundPath
      let clusterConfigDirPath = path.dirname(clusterConfigPath)

      // console.log(clusterConfigPath)
      // console.log(clusterConfigDirPath)

      const clusterConfig = yaml.load((await fs.readFile(clusterConfigPath, "utf8")))
      const defaultClusterConfig = yaml.load((await fs.readFile(defaultClusterConfigPath, "utf8")))

      const data = {...defaultClusterConfig, ...clusterConfig}
      // console.log(clusterConfig.cluster.config.context)
      this.clusterConfig = data
      this.clusterConfigPath = clusterConfigPath
      this.clusterConfigDirPath = clusterConfigDirPath

    }
    // let clusterConfigDirPath = path.join(found, '..')
    // let yamllintConfigPath = path.join(clusterConfigDirPath, 'yamllint.yaml')



  }
}
