import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../base";
import upath from "upath";
import YAML from "yaml";
import * as fs from "fs-extra";
export default class GenerateHelmfiles extends BaseCommand {
  static description = "Generate helmfiles to setup your project quickly";

  static examples = [
    `# Platform only
$ kube-core generate helmfiles
# Platform + Default Envs
$ kube-core generate helmfiles --defaultEnvs
# Platform + Any Env
$ kube-core generate helmfiles --envs=integration,validation,preproduction,production
$ kube-core generate helmfiles --envs=integration --envs=validation --envs=preproduction --envs=production
# Platform + Default Envs + Any Env
$ kube-core generate helmfiles --defaultEnvs --envs=qa,test
# Disabling what you don't need
$ kube-core generate helmfiles --no-lib --no-core --no-services --defaultEnvs
`,
  ];

  static flags = {
    lib: Flags.boolean({
      description:
        "Generates helmfiles/lib folder, with templates and utility functions. Enabled by default. Use --no-lib to disable.",
      hidden: false,
      required: false,
      allowNo: true,
      default: true,
    }),
    commons: Flags.boolean({
      description:
        "Generates common.helmfile.yaml.gotmpl to share common configuration between all helmfiles. Enabled by default. Use --no-commons to disable.",
      hidden: false,
      required: false,
      allowNo: true,
      default: true,
    }),
    core: Flags.boolean({
      description:
        "Generates core, cluster and local helmfiles to allow using kube-core platform. Enabled by default. Use --no-core to disable.",
      hidden: false,
      required: false,
      allowNo: true,
      default: true,
    }),
    applications: Flags.boolean({
      description:
        "Generates applications helmfiles for all environments. Provide --envs or --defaultEnvs with it. Enabled by default. Use --no-applications to disable.",
      hidden: false,
      required: false,
      allowNo: true,
      default: true,
    }),
    services: Flags.boolean({
      description:
        "Generates services helmfiles for all environments. Provide --envs or --defaultEnvs with it. Enabled by default. Use --no-services to disable.",
      hidden: false,
      required: false,
      allowNo: true,
      default: true,
    }),
    envs: Flags.string({
      description:
        "A comma separated list of envs to generate. Use it with --applications and/or --services.",
      hidden: false,
      required: false,
      multiple: true,
      default: [],
      parse: async (input) => {
        if (Array.isArray(input)) {
          return input;
        } else {
          return input.split(",");
        }
      },
    }),
    defaultEnvs: Flags.boolean({
      description:
        "Use it to generate default kube-core envs for a quickstart. Use it with --applications and/or --services.",
      hidden: false,
      required: false,
      default: false,
    }),
    localRefs: Flags.boolean({
      description:
        "Writes down local helmfile refs instead of using KUBE_CORE_LOCAL_CORE_PATH env var",
      hidden: false,
      required: false,
      default: false,
    }),
  };

  static args = [];

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(GenerateHelmfiles);
    let envs = undefined;
    let defaultEnvs = [
      "dev",
      "integration",
      "validation",
      "preproduction",
      "production",
    ];
    // Handling different outputs for envs flags
    if (flags.envs !== undefined) {
      // --envs=env1 --envs=env2
      if (flags.envs.length > 1) {
        envs = flags.envs.map((item) => item[0]);
        // --envs=env1,env2
      } else {
        envs = flags.envs[0];
      }
    }
    if (flags.defaultEnvs === true && envs !== undefined) {
      envs = [...defaultEnvs, ...envs];
    } else if (flags.defaultEnvs === true && envs === undefined) {
      envs = defaultEnvs;
    }
    const localDir = upath.join(this.clusterConfigDirPath, "helmfiles");
    this.utils.mkdir(localDir);

    let files;
    let writtenFiles = {
      core: [],
      lib: [],
      applications: [],
      services: [],
    };

    // Core
    if (flags.core) {
      files = await this.utils.getFilesAsList(
        upath.join(this.corePath, `core`, `templates`, `generate`, `core`)
      );
      for (let file of files) {
        let { name, ext } = upath.parse(file);
        let targetPath = upath.join(localDir, `${name}${ext}`);
        let fileData = await fs.readFile(file, "utf8");
        fileData = fileData.replaceAll(
          "KUBE_CORE_CLUSTER_CONFIG_CONTEXT",
          this.clusterConfig.cluster.config.context
        );
        await this.utils.mkdir(upath.parse(targetPath).dir);
        await fs.writeFile(targetPath, fileData);
        writtenFiles.core.push(
          upath.relative(this.clusterConfigDirPath, targetPath)
        );
      }
    }

    if (flags.lib) {
      const localLibDir = upath.join(
        this.clusterConfigDirPath,
        `helmfiles`,
        `lib`
      );
      this.utils.mkdir(localLibDir);

      // Getting lib
      files = await this.utils.getFilesAsList(
        upath.join(this.corePath, "core/templates/lib")
      );
      for (let file of files) {
        let { name, ext } = upath.parse(file);
        let targetPath = upath.join(localLibDir, `${name}${ext}`);
        let fileData = await fs.readFile(file, "utf8");

        fileData = fileData.replaceAll(
          "HELMFILE_NAME",
          name.split(".")[0].toUpperCase()
        );

        fileData = fileData.replaceAll(
          "KUBE_CORE_HELMFILES_CORE_REMOTE_PATH",
          [
            `git::${this.coreRemotePath}@`,
            "core",
            `helmfile.yaml.gotmpl?ref=v${this.config.version}`,
          ].join("/")
        );
        fileData = fileData.replaceAll(
          "KUBE_CORE_HELMFILES_CLUSTER_REMOTE_PATH",
          [
            `git::${this.coreRemotePath}@`,
            "core",
            `cluster.yaml.gotmpl?ref=v${this.config.version}`,
          ].join("/")
        );
        fileData = fileData.replaceAll(
          "KUBE_CORE_HELMFILES_LOCAL_REMOTE_PATH",
          [
            `git::${this.coreRemotePath}@`,
            "core",
            `cluster.yaml.gotmpl?ref=v${this.config.version}`,
          ].join("/")
        );
        fileData = fileData.replaceAll(
          "KUBE_CORE_HELMFILES_APPLICATIONS_REMOTE_PATH",
          [
            `git::${this.coreRemotePath}@`,
            "core",
            `applications.yaml.gotmpl?ref=v${this.config.version}`,
          ].join("/")
        );
        fileData = fileData.replaceAll(
          "KUBE_CORE_HELMFILES_SERVICES_REMOTE_PATH",
          [
            `git::${this.coreRemotePath}@`,
            "core",
            `services.yaml.gotmpl?ref=v${this.config.version}`,
          ].join("/")
        );

        if(flags.localRefs) {
          fileData = fileData.replaceAll(
            "KUBE_CORE_HELMFILES_CORE_LOCAL_PATH",
            upath.join(this.corePath, "core", "helmfile.yaml.gotmpl")
          );
          fileData = fileData.replaceAll(
            "KUBE_CORE_HELMFILES_CLUSTER_LOCAL_PATH",
            upath.join(this.corePath, "core", "cluster.yaml.gotmpl")
          );
          fileData = fileData.replaceAll(
            "KUBE_CORE_HELMFILES_LOCAL_LOCAL_PATH",
            upath.join(this.corePath, "core", "cluster.yaml.gotmpl")
          );
          fileData = fileData.replaceAll(
            "KUBE_CORE_HELMFILES_APPLICATIONS_LOCAL_PATH",
            upath.join(this.corePath, "core", "applications.yaml.gotmpl")
          );
          fileData = fileData.replaceAll(
            "KUBE_CORE_HELMFILES_SERVICES_LOCAL_PATH",
            upath.join(this.corePath, "core", "services.yaml.gotmpl")
          );
        }



        await this.utils.mkdir(upath.parse(targetPath).dir);
        await fs.writeFile(targetPath, fileData);
        writtenFiles.lib.push(
          upath.relative(this.clusterConfigDirPath, targetPath)
        );
      }
    }

    if (flags.commons) {
      files = await this.utils.getFilesAsList(
        upath.join(this.corePath, `core`, `templates`, `generate`, `commons`)
      );
      for (let file of files) {
        let { name, ext } = upath.parse(file);
        let targetPath = upath.join(localDir, `${name}${ext}`);
        let fileData = await fs.readFile(file, "utf8");
        fileData = fileData.replaceAll(
          "KUBE_CORE_CLUSTER_CONFIG_CONTEXT",
          this.clusterConfig.cluster.config.context
        );
        await this.utils.mkdir(upath.parse(targetPath).dir);
        await fs.writeFile(targetPath, fileData);
        writtenFiles.core.push(
          upath.relative(this.clusterConfigDirPath, targetPath)
        );
      }
    }

    // Envs
    if (flags.applications && envs) {
      files = await this.utils.getFilesAsList(
        upath.join(this.corePath, `core`, `templates`, `generate`, `envs`)
      );
      for (let file of files) {
        for (let env of envs) {
          let { name, ext } = upath.parse(file);
          let targetPath = upath.join(
            localDir,
            `${env}.applications.helmfile.yaml.gotmpl`
          );
          let fileData = await fs.readFile(file, "utf8");
          fileData = fileData.replaceAll(
            "KUBE_CORE_CLUSTER_CONFIG_CONTEXT",
            this.clusterConfig.cluster.config.context
          );
          fileData = fileData.replaceAll("KUBE_CORE_ENV_NAME", env);
          fileData = fileData.replaceAll(
            "KUBE_CORE_RELEASE_TYPE",
            "application"
          );
          await this.utils.mkdir(upath.parse(targetPath).dir);
          await fs.writeFile(targetPath, fileData);
          writtenFiles.applications.push(
            upath.relative(this.clusterConfigDirPath, targetPath)
          );
        }
      }
    }

    if (flags.services && envs) {
      files = await this.utils.getFilesAsList(
        upath.join(this.corePath, `core`, `templates`, `generate`, `envs`)
      );
      for (let file of files) {
        for (let env of envs) {
          let { name, ext } = upath.parse(file);
          let targetPath = upath.join(
            localDir,
            `${env}.services.helmfile.yaml.gotmpl`
          );
          let fileData = await fs.readFile(file, "utf8");
          fileData = fileData.replaceAll(
            "KUBE_CORE_CLUSTER_CONFIG_CONTEXT",
            this.clusterConfig.cluster.config.context
          );
          fileData = fileData.replaceAll("KUBE_CORE_ENV_NAME", env);
          fileData = fileData.replaceAll("KUBE_CORE_RELEASE_TYPE", "service");
          await this.utils.mkdir(upath.parse(targetPath).dir);
          await fs.writeFile(targetPath, fileData);
          writtenFiles.applications.push(
            upath.relative(this.clusterConfigDirPath, targetPath)
          );
        }
      }
    }

    // console.log(writtenFiles)
    let result = { helmfiles: [] };
    let toPush = [
      ...writtenFiles.core,
      ...writtenFiles.applications,
      ...writtenFiles.services,
    ];
    for (const file of toPush) {
      if (file.includes("helmfile.yaml.gotmpl")) {
        result.helmfiles.push({ path: `./${file}` });
      }
    }
    // console.log(YAML.stringify(result))
    await fs.writeFile(
      upath.join(this.clusterConfigDirPath, "helmfile.yaml"),
      YAML.stringify(result)
    );
  }
}
