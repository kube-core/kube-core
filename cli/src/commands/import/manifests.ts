import StdinCommand from "../../stdin";
import { Flags } from "@oclif/core";
import upath from "upath";
import * as fs from "fs-extra";

export default class ImportManifests extends StdinCommand {
  static description =
    "Quickly import some manifests to a local release.";

  static examples = [`# Importing some manifests to a local release
$ curl -s https://raw.githubusercontent.com/opencost/opencost/develop/kubernetes/opencost.yaml | kube-core import manifests`];

  static flags = {
    outputDir: Flags.string({
      description: "The directory to output imported manifests. Defaults to ./local/releases",
      hidden: false,
      required: false,
    }),
    namespace: Flags.string({
      char: "n",
      description: "The namespace to import manifests in. Required.",
      hidden: false,
      required: true,
    }),
  };
  static args = []

  async kubectlSlice(input, outputDir = './sliced', namespace = '{{.metadata.namespace}}') {

    const result = await this.utils.cliStream("kubectl", ["slice", `--output-dir=${outputDir}`, `--template=${namespace}/{{.kind|lower}}/{{.metadata.name|dottodash|replace ":" "-"}}.yaml`], {input: input, maxBuffer: 900_000_000 })
    // return result.stdout

    // console.log(result.stdout)
    let list = await this.utils.getFilesAsParsedList(outputDir)
    // console.log(list)

    for(let parsedFile of list) {
      let file = upath.format(parsedFile)

      if(parsedFile.name === "" ){
        // console.log('empty name')
        fs.unlink(file)
        continue
      }

      if(parsedFile.ext === "" ){
        // console.log('empty ext')
        fs.unlink(file)
        continue
      }

      if(parsedFile.dir.split(upath.sep).at(-1) === "namespace" ){
        // console.log('empty ext')
        fs.rm(parsedFile.dir,{ recursive: true })
        continue
      }

      let data = await fs.readFile(file, "utf8")
      if(data === "") {
        // console.log("empty file")
        fs.unlink(file)
        continue
      }
    }


  }



  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(ImportManifests);

    let input = ImportManifests.stdin
    let localReleasesFolder = upath.join(this.clusterConfigDirPath, "local", "releases")
    let outputDir = localReleasesFolder

    this.utils.mkdir(localReleasesFolder)
    let namespace = flags.namespace

    await this.kubectlSlice(input, outputDir, namespace)

    }

}
