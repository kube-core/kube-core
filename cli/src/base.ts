import { Command, Flags } from "@oclif/core";
import * as utils from "./lib/utils";



export default abstract class extends Command {
  public utils;

  static flags = {
    // name: Flags.string({
    //   char: 'n',                    // shorter flag version
    //   description: 'name to print', // help description for flag
    //   hidden: false,                // hide from help
    //   multiple: false,              // allow setting this flag multiple times
    //   env: 'MY_NAME',               // default to value of environment variable
    //   options: ['a', 'b'],          // only allow the value to be from a discrete set
    //   parse: input => 'output',     // instead of the user input, return a different value
    //   default: 'world',             // default value if flag not passed (can be a function that returns a string or undefined)
    //   required: false,              // make flag required (this is not common and you should probably use an argument instead)
    //   dependsOn: ['extra-flag'],    // this flag requires another flag
    //   exclusive: ['extra-flag'],    // this flag cannot be specified alongside this other flag
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
  }
}
