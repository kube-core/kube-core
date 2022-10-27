import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../base";

export default class ScriptsList extends BaseCommand {
  static description = "Executes a kube-core script";

  static examples = [`$ kube-core scripts:exec script_name arg1 arg2 arg3`];

  static flags = {};

  static args = [];

  static strict = false;

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(ScriptsList);
    let scriptsList = await this.utils.runCoreScriptAsync(
      "commands/scripts/cat.sh"
    );

    let parsedScriptsList = JSON.parse(scriptsList.stdout);
    // console.log(parsedScriptsList)

    for (const i in parsedScriptsList) {
      let script = parsedScriptsList[i];
      if (script.name === argv[0]) {
        argv.shift();
        let output = await this.utils.runClusterScript(script.path, argv);
      }
    }
    // console.log(argv[0])
  }
}
