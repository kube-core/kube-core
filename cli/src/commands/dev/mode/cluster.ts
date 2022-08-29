import BaseCommand from "../../../base";

export default class Cluster extends BaseCommand {
  static description =
    "Switches current cluster references to kube-core to local version instead of released one. Used for development.";

  static examples = [`$ kube-core dev:mode:cluster`];

  static flags = {};

  static args = [];

  static strict = false

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(Cluster);

    await this.utils.runClusterScript("commands/dev/mode/cluster.sh", argv);

  }
}
