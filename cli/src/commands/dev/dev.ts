import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../base";
import watch from "node-watch";
import * as path from "path";
import findUp from "find-up";
import execa from "execa";

export default class Dev extends BaseCommand {
  static description = "Command used for development only";

  static examples = [`$ kube-core dev dev`];

  static flags = {
    namespace: Flags.string({
      char: "n",
      description: "namespace to use",
      hidden: false,
      multiple: false,
      default: "default",
      required: false,
    }),
  };

  static args = [];

  static strict = false;

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(Dev);
    if (this.clusterContext === true) {
      // Test
      // let viewsPath = path.join(this.clusterConfigDirPath, "views")
      // await this.utils.mkdir(viewsPath)
      // let files = await this.utils.loadYamlFilesFromPath(this.clusterConfigDirPath)
      // console.log(files)

      const filter = argv.join(" ");
      const data = this.clusterConfig;
      const options = { input: "json" };

      const test = await this.utils.jq(filter, data, options);
      // console.log(test);
      console.log(this.corePath);
      return;
    } else {
      console.warn("Aborted. This command only works in cluster context.");
    }
  }
}
