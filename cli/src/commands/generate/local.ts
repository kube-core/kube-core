import BaseCommand from "../../base";
import upath from "upath";
export default class GenerateLocal extends BaseCommand {
  static description =
    "Generates all local folders that are used by kube-core";

  static examples = [`$ kube-core generate local`];

  static flags = {};

  static args = [];

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(GenerateLocal);
    await this.utils.mkdir(upath.join(this.clusterConfigDirPath, "local"));
    await this.utils.mkdir(upath.join(this.clusterConfigDirPath, "local", "build"));
    await this.utils.mkdir(upath.join(this.clusterConfigDirPath, "local", "config"));
    await this.utils.mkdir(upath.join(this.clusterConfigDirPath, "local", "configmaps"));
    await this.utils.mkdir(upath.join(this.clusterConfigDirPath, "local", "configmaps", "input"));
    await this.utils.mkdir(upath.join(this.clusterConfigDirPath, "local", "configmaps", "manifests"));
    await this.utils.mkdir(upath.join(this.clusterConfigDirPath, "local", "configmaps", "output"));
    await this.utils.mkdir(upath.join(this.clusterConfigDirPath, "local", "configmaps", "replicated"));
    await this.utils.mkdir(upath.join(this.clusterConfigDirPath, "local", "configmaps-releases"));
    await this.utils.mkdir(upath.join(this.clusterConfigDirPath, "local", "crds"));
    await this.utils.mkdir(upath.join(this.clusterConfigDirPath, "local", "overlays"));
    await this.utils.mkdir(upath.join(this.clusterConfigDirPath, "local", "patches"));
    await this.utils.mkdir(upath.join(this.clusterConfigDirPath, "local", "releases"));
    await this.utils.mkdir(upath.join(this.clusterConfigDirPath, "local", "secrets"));
    await this.utils.mkdir(upath.join(this.clusterConfigDirPath, "local", "secrets", "input"));
    await this.utils.mkdir(upath.join(this.clusterConfigDirPath, "local", "secrets", "manifests"));
    await this.utils.mkdir(upath.join(this.clusterConfigDirPath, "local", "secrets", "output"));
    await this.utils.mkdir(upath.join(this.clusterConfigDirPath, "local", "secrets", "replicated"));
    await this.utils.mkdir(upath.join(this.clusterConfigDirPath, "local", "secrets-releases"));
  }
}
