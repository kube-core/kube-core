import { Command, Flags } from "@oclif/core";
import upath from "upath";
import yaml from "js-yaml";
import * as utils from "./lib/utils";
import findUp from "find-up";
import * as fs from "fs-extra";
import merge from "lodash.merge";
const { lookpath } = require("lookpath");


export default abstract class CustomCommand extends Command {
  public utils;
  public scriptsPath;
  public corePath;
  public coreRemotePath;
  public clusterContext;
  public clusterConfig;
  public clusterConfigPath;
  public clusterConfigDirPath;
  public valuesPath;
  public gitopsConfigHasChanges;
  public values;

  static stdin: string

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
  };
  async checkRequirements() {
    const gron = await lookpath("gron");
    if (gron === undefined) {
      console.error(
        "Please install gron on your system and make it available to your path. https://github.com/tomnomnom/gron"
      );
      process.exit(0);
    }
  }

  async init() {
    this.utils = utils;
    this.values = {
      core: {},
      cluster: {},
      envs: {},
      platform: {},
    }

    await this.checkRequirements();

    this.scriptsPath = `${upath.resolve(
      `${require.main.filename}/../../scripts`
    )}`;
    this.corePath = `${upath.resolve(`${this.scriptsPath}/../../`)}`;
    this.coreRemotePath = "https://github.com/kube-core/kube-core.git";
    let scriptPath = `${upath.join(
      this.scriptsPath,
      "src/utils/read-core-path.sh"
    )}`;
    let defaultClusterConfigPath = upath.join(
      this.scriptsPath,
      "default-cluster-config.yaml"
    );
    let file = "cluster-config.yaml";

    // let corePath = await this.utils.cliQuiet(scriptPath);
    // let clusterConfigPath = `${upath.join(this.corePath, "src/utils/read-core-path.sh")}`

    const foundPath = await findUp(file);
    if (!foundPath) {
      this.clusterContext = false;
      // throw new Error(`${file} not found, searching "upwards" from ${process.cwd()}`)
    } else {
      this.clusterContext = true;
      let clusterConfigPath = foundPath;
      let clusterConfigDirPath = upath.dirname(clusterConfigPath);

      // console.log(clusterConfigPath)
      // console.log(clusterConfigDirPath)

      const clusterConfig = yaml.load(
        await fs.readFile(clusterConfigPath, "utf8")
      );
      const defaultClusterConfig = yaml.load(
        await fs.readFile(defaultClusterConfigPath, "utf8")
      );

      const data = merge(defaultClusterConfig, clusterConfig);
      // console.log(clusterConfig.cluster.config.context)
      this.clusterConfig = data;
      this.clusterConfigPath = clusterConfigPath;
      this.clusterConfigDirPath = clusterConfigDirPath;
      this.valuesPath = upath.join(clusterConfigDirPath, "values");

      // let valuesData = await this.utils.loadValuesAsArray(this.valuesPath)
      // console.log(merge(...valuesData))


      // Checking if git workspace is clean
      this.gitopsConfigHasChanges = false;
      const gitStatus = await this.utils.cliStream(
        "git",
        [
          "status",
          "--porcelain",
          upath.join(this.clusterConfigDirPath, "config"),
        ],
        { maxBuffer: 300_000_000 }
      );
      if (gitStatus.stdout != "") {
        this.gitopsConfigHasChanges = true;
      }
    }
    // let clusterConfigDirPath = path.join(found, '..')
    // let yamllintConfigPath = path.join(clusterConfigDirPath, 'yamllint.yaml')
  }
}
