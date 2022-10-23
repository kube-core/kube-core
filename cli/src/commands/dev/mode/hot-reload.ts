import BaseCommand from "../../../base";
import watch from 'node-watch'
import * as path from "path";
import findUp from 'find-up';
import * as upath from "upath"
import { Flags } from "@oclif/core";

export default class DevModeHotReload extends BaseCommand {
  static description =
    "Experimental feature. Watches changes in ./dev/config and applies them.";

  static examples = [`$ kube-core dev mode hot-reload`];

  static flags = {
    remove: Flags.boolean({
      description: 'Forces removal of resources on file deletion',
      hidden: false,
      default: false,
      required: false
    })
  }
  static args = [];

  static strict = false

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(DevModeHotReload);

    // let output = await this.utils.runClusterScriptAsync("src/utils/read-cluster-path.sh", argv)
    // console.log(output.stdout)

    process.setMaxListeners(20)
    let file = 'cluster-config.yaml'

    const found = await findUp(file)
    if (!found) {
      throw new Error(`${file} not found, searching "upwards" from ${process.cwd()}`)
    }

    let clusterConfigDirPath = path.join(found, '..')
    let yamllintConfigPath = path.join(clusterConfigDirPath, 'yamllint.yaml')
    // console.log(clusterConfigDirPath)



    let localDevConfigPath = path.resolve(`${clusterConfigDirPath}/dev/config`)
    // let localConfigPath = path.resolve(`${clusterConfigDirPath}/local/config`)

    // let secretsInputPath = path.resolve(`${clusterConfigDirPath}/local/secrets/input`)
    // let secretsManifestsPath = path.resolve(`${clusterConfigDirPath}/local/secrets/manifests`)
    // let secretsOutputPath = path.resolve(`${clusterConfigDirPath}/local/secrets/output`)

    // let configMapsInputPath = path.resolve(`${clusterConfigDirPath}/local/configmaps/input`)
    // let configMapsManifestsPath = path.resolve(`${clusterConfigDirPath}/local/configmaps/manifests`)
    // let configMapsOutputPath = path.resolve(`${clusterConfigDirPath}/local/configmaps/output`)


    console.log(`Watching: ${localDevConfigPath}`)
    // console.log(`Watching: ${localConfigPath}`)

    // console.log(`Watching: ${secretsInputPath}`)
    // console.log(`Watching: ${secretsManifestsPath}`)
    // console.log(`Watching: ${secretsOutputPath}`)

    // console.log(`Watching: ${configMapsInputPath}`)
    // console.log(`Watching: ${configMapsManifestsPath}`)
    // console.log(`Watching: ${configMapsOutputPath}`)

    watch(localDevConfigPath, { recursive: true }, async (evt, name) => {
        if (evt == 'update') {
            // let namespacedPath = name.split(path.sep).slice(-4).join('/')
            // console.log('%s changed.', namespacedPath);
            // await this.utils.cliPipe('cat', [`${name}`])
            try {
              // console.log(name)
                // await this.utils.cliPipe('kubectl', ['diff', '-f', `${upath.normalizeSafe(name)}`])
                await this.utils.cliPipe('kubectl', ['apply', '-f', `${upath.normalizeSafe(name)}`, '--dry-run=client'])
            } catch(e: any) {
                console.log(e.message)
            }
        } else if (evt == 'remove' && flags.remove === true) {
            await this.utils.cliPipe('kubectl', ['delete', '-f', `${upath.normalizeSafe(name)}`, '--dry-run=client'])
        } else {

        }
    });

    // watch(localConfigPath, { recursive: true }, async (evt, name) => {
    //     if (evt == 'update') {
    //         // let namespacedPath = name.split(path.sep).slice(-4).join('/')
    //         // console.log('%s changed.', namespacedPath);
    //         await this.utils.cliPipe('cat', [`${name}`])

    //         // let output = await this.utils.cliPipe('yamllint', [`${name}`, '-c', yamllintConfigPath])
    //         let testOutput = await this.utils.testKubernetesManifest(name)
    //         // console.log(output)
    //     } else if (evt == 'remove') {

    //     } else {

    //     }
    // });

    // watch(secretsInputPath, { recursive: true }, async (evt, name) => {
    //     if (evt == 'update') {
    //         let namespacedPath = name.split(path.sep).slice(-4).join('/')
    //         console.log('%s changed.', namespacedPath);
    //         let secrets = await this.utils.runClusterScript("src/k8s/secrets/generate.sh", [namespacedPath]);
    //     } else if (evt == 'remove') {

    //     } else {

    //     }
    // });

    // watch(secretsManifestsPath, { recursive: true, filter: /\.yaml$/ }, async (evt, name) => {
    //     if (evt == 'update') {
    //         let namespacedPath = name.split(path.sep).slice(-4).join('/')
    //         console.log('%s changed.', namespacedPath);
    //         let secrets = await this.utils.runClusterScript("src/k8s/secrets/generate.sh", [namespacedPath]);
    //     } else if (evt == 'remove') {

    //     } else {

    //     }
    // });


    // watch(secretsOutputPath, { recursive: true, filter: /\.yaml$/ }, async (evt, name) => {
    //     if (evt == 'update') {
    //         // console.log(evt)
    //         let namespacedPath = name.split(path.sep).slice(-4).join('/')
    //         console.log('%s changed.', namespacedPath);
    //         // console.log("Applying changes... (dry run for now)")
    //         let testOutput = await this.utils.testKubernetesManifest(name)
    //         let output = await this.utils.cliPipe('kubectl', ['apply', '-f', name, '--dry-run=client'])
    //         // console.log(output)
    //     } else if (evt == 'remove') {

    //     } else {

    //     }
    // });

    // watch(configMapsInputPath, { recursive: true }, async (evt, name) => {
    //     if (evt == 'update') {
    //         let namespacedPath = name.split(path.sep).slice(-4).join('/')
    //         console.log('%s changed.', namespacedPath);
    //         let configMaps = await this.utils.runClusterScript("src/k8s/configmaps/generate.sh", [namespacedPath]);

    //     } else if (evt == 'remove') {

    //     } else {

    //     }
    // });

    // watch(configMapsManifestsPath, { recursive: true, filter: /\.yaml$/ }, async (evt, name) => {
    //     if (evt == 'update') {
    //         let namespacedPath = name.split(path.sep).slice(-4).join('/')
    //         console.log('%s changed.', namespacedPath);
    //         let configMaps = await this.utils.runClusterScript("src/k8s/configmaps/generate.sh", [namespacedPath]);

    //     } else if (evt == 'remove') {
    //     } else {

    //     }
    // });


    // watch(configMapsOutputPath, { recursive: true, filter: /\.yaml$/ }, async (evt, name) => {
    //     if (evt == 'update') {
    //         // console.log(evt)
    //         let namespacedPath = name.split(path.sep).slice(-4).join('/')
    //         console.log('%s changed.', namespacedPath);
    //         // console.log("Applying changes... (dry run for now)")

    //         let testOutput = await this.utils.testKubernetesManifest(name)
    //         let output = await this.utils.cliPipe('kubectl', ['apply', '-f', name, '--dry-run=client'])

    //         // console.log(output)
    //     } else if (evt == 'remove') {

    //     } else {

    //     }
    // });


  }
}
