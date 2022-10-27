import BaseCommand from "../../../base";
import * as path from "path";

export default class GitopsConfigFind extends BaseCommand {
  static description = "Find files in your GitOps config";

  static examples = [
    `# List all resources
$ kube-core gitops config find
# List resources with a matching path
$ kube-core gitops config find velero`,
  ];

  static flags = {};

  static args = [];

  static strict = false;

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(GitopsConfigFind);
    if (this.clusterContext === true) {
      let fileList = await this.utils.getFilesAsList(
        path.join(this.clusterConfigDirPath, "config")
      );

      let filter = "";
      if (argv[0]) {
        filter = argv[0];
        let filteredList = fileList.filter((item) => item.includes(filter));
        for (let filePath of filteredList) {
          console.log(filePath);
        }
      } else {
        for (let filePath of fileList) {
          console.log(filePath);
        }
      }
    } else {
      console.warn("Aborted. This command only works in cluster context.");
    }
  }
}
