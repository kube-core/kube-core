import { Command, Flags } from "@oclif/core";
import path from "path";
import yaml from "js-yaml";
import * as utils from "./lib/utils";
import findUp from 'find-up';
import * as fs from 'fs-extra'


export default abstract class extends Command {
  public utils;
  public scriptsPath;
  public clusterConfig

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
    let corePath = await this.utils.cliQuiet(scriptPath);
    // let clusterConfigPath = `${path.join(this.corePath, "src/utils/read-core-path.sh")}`
    let file = 'cluster-config.yaml'

    const foundPath = await findUp(file)
    if (!foundPath) {
      // throw new Error(`${file} not found, searching "upwards" from ${process.cwd()}`)
    } else {

      let clusterConfigPath = foundPath
      let clusterConfigDirPath = path.dirname(clusterConfigPath)

      // console.log(clusterConfigPath)
      // console.log(clusterConfigDirPath)

      const clusterConfig = yaml.load((await fs.readFile(clusterConfigPath, "utf8")))
      // console.log(clusterConfig.cluster.config.context)
      this.clusterConfig = clusterConfig

    }
    // let clusterConfigDirPath = path.join(found, '..')
    // let yamllintConfigPath = path.join(clusterConfigDirPath, 'yamllint.yaml')



  }
}
