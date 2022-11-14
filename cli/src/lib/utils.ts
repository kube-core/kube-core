import * as child from "child_process";
import { spawn, spawnSync } from "child_process";
import * as path from "path";
import * as fs from "fs-extra";
import * as upath from "upath";
import YAML from "yaml";
import * as nodejq from "node-jq";
import { json } from "stream/consumers";
import FuzzySet from "fuzzyset";
import merge from "lodash.merge";

// import execa from "execa";
const execa = require("execa");

const defaultExecaOptions = { maxBuffer: 900_000_000 }

export async function cli(cmd, ...args) {
  try {
    const { stdout } = await execa(cmd, args);
    console.log(stdout);
  } catch (error) {
    console.log(error);
  }
}

export async function cliQuiet(cmd, args, env = {}) {
  try {
    let output = execa(cmd, args, { maxBuffer: 300_000_000, env: env });
    return output;
  } catch (error) {
    console.log(error);
  }
}

export async function cliStream(cmd, args, options = {}) {
  try {
    let output = execa(cmd, args, options);
    return output;
  } catch (error) {
    console.log(error);
  }
}

export async function cliStreamPipe(cmd, args, options = {}) {
  try {
    let output = execa(cmd, args, options);
    output.stdout.pipe(process.stdout);
    output.stderr.pipe(process.stderr);
    return output;
  } catch (error) {
    console.log(error);
  }
}

export async function cliPipe(cmd, args, env = {}, input = undefined) {
  try {
    // let output = execa("env", args, {maxBuffer: 300_000_000, env: {HELM_DIFF_IGNORE_UNKNOWN_FLAGS: "true", extendEnv: false} })
    let extraOptions = { input: undefined };
    if (input) {
      extraOptions.input = input;
    }
    let output = execa(cmd, args, {
      maxBuffer: 300_000_000,
      env: env,
      input: extraOptions.input,
    });
    output.stdout.pipe(process.stdout);
    output.stderr.pipe(process.stderr);
    // process.exit()
    return output;
  } catch (error) {
    console.log(error);
  }
}

export async function runScript(script, args, env = {}) {
  let scriptsPath = `${path.resolve(`${require.main.filename}/../../scripts`)}`;
  let scriptPath = `${path.join(scriptsPath, script)}`;
  let output;

  try {
    output = await cliPipe(scriptPath, args, env);
  } catch (error) {
    console.log(error);
  }
  return output;
}

export async function runCoreScript(script, args, env = {}) {
  let scriptsPath = `${path.resolve(`${require.main.filename}/../../scripts`)}`;
  let scriptPath = `${path.join(scriptsPath, script)}`;
  let output;

  try {
    output = await cliPipe(scriptPath, args, env);
  } catch (error) {
    console.log(error);
  }
  return output;
}

export async function runCoreScriptAsync(script, args, env = {}) {
  let scriptsPath = `${path.resolve(`${require.main.filename}/../../scripts`)}`;
  let scriptPath = `${path.join(scriptsPath, script)}`;

  let output;

  try {
    output = await execa(scriptPath, args);
  } catch (error) {
    console.log(error);
  }
  return output;
}

export async function runClusterScript(script, args, env = {}) {
  let scriptsPath = `${path.resolve(`${require.main.filename}/../../scripts`)}`;
  let scriptPath = `${path.join(scriptsPath, script)}`;
  let output;

  try {
    output = await cliPipe(scriptPath, args, env);
  } catch (error) {
    console.log(error);
  }
  return output;
}

export async function runClusterTestScript(script, args, env = {}) {
  let scriptsPath = `${path.resolve(`${require.main.filename}/../../scripts`)}`;
  let scriptPath = `${path.join(scriptsPath, script)}`;
  let output;

  try {
    output = await cliPipe(scriptPath, args, env);
  } catch (error) {
    if (error.exitCode > 0) {
      if (
        process.env.LOG_LEVEL == "DEBUG" ||
        process.env.LOG_LEVEL == "INSANE"
      ) {
        console.log(error);
      }
      process.exit(error.exitCode);
    }
  }
  return output;
}
export async function mkdir(path: string) {
  try {
    await fs.mkdir(path, { recursive: true });
  } catch (e) {
    console.error(e);
  }
}

export async function loadYamlFile(path) {
  let data = YAML.parse(await fs.readFile(path, "utf8"));
  return data
}
export async function writeYamlFile(path, data) {
  await this.utils.mkdir(upath.parse(path).dir);
  await fs.writeFile(path, YAML.stringify(data));
  return data
}

export async function mergeYamlFilesAtTargetPath(targetPath, ...sourcePaths) {

  let data = {}
  let filesData = []
  for(let path of sourcePaths) {
    filesData.push(await this.loadYamlFile(path))
  }

  data = merge(...sourcePaths)

  await this.writeYamlFile(upath.normalizeSafe(targetPath), data)

  return data
}

export async function importResourcesAsLocalReleases(resources) {

}


export async function loadYamlFilesFromPath(
  clusterConfigDirPath: string,
  targetPath = "config",
  absolute = false
) {
  let filesPath = path.join(clusterConfigDirPath, targetPath);
  try {
    let files = [];
    for await (const file of this.getFiles(filesPath)) {
      let data = await this.loadYamlFile(file)
      let filePath = upath.normalizeSafe(file);

      if (absolute === false) {
        filePath = filePath.replace(
          upath.normalizeSafe(clusterConfigDirPath),
          ""
        );
      }
      files.push(data);
    }
    return files;
  } catch (e) {
    console.error(e);
  }
}
export async function loadYamlFilesFromPathAsDataArray(
  clusterConfigDirPath: string,
  targetPath = "config",
  absolute = false
) {
  let filesPath = path.join(clusterConfigDirPath, targetPath);
  try {
    let files = [];
    for await (const file of this.getFiles(filesPath)) {
      let data = await this.loadYamlFile(file)
      let filePath = upath.normalizeSafe(file);

      if (absolute === false) {
        filePath = filePath.replace(
          upath.normalizeSafe(clusterConfigDirPath),
          ""
        );
      }
      let resource = { path: filePath, data: data };
      files.push(resource);
    }
    return files;
  } catch (e) {
    console.error(e);
  }
}
export async function loadYamlFilesFromPathAsDataObject(
  clusterConfigDirPath: string,
  targetPath = "config",
  absolute = false
) {
  let filesPath = path.join(clusterConfigDirPath, targetPath);
  try {
    let files = {};
    for await (const file of this.getFiles(filesPath)) {
      let data = await this.loadYamlFile(file)
      let filePath = upath.normalizeSafe(file);

      if (absolute === false) {
        filePath = filePath.replace(
          upath.normalizeSafe(clusterConfigDirPath),
          ""
        );
      }
      files[filePath] = data;
    }
    return files;
  } catch (e) {
    console.error(e);
  }
}
export async function getFilesAsList(targetPath) {
  try {
    let files = [];
    for await (const file of this.getFiles(upath.normalizeSafe(targetPath))) {
      files.push(upath.normalizeSafe(file));
    }
    return files;
  } catch (e) {
    console.error(e);
  }
}

export async function getFilesAsParsedList(targetPath) {
  return (await this.getFilesAsList(targetPath)).map(item => upath.parse(item))
}

export async function loadYamlFilesFromPathAsItemsList(
  clusterConfigDirPath: string,
  targetPath = "config",
  absolute = false
) {
  let filesPath = path.join(clusterConfigDirPath, targetPath);
  try {
    let files = { kind: "List", items: [] };
    for await (const file of this.getFiles(filesPath)) {
      let data = YAML.parse(await fs.readFile(file, "utf8"));
      let filePath = upath.normalizeSafe(file);

      if (absolute === false) {
        filePath = filePath.replace(
          upath.normalizeSafe(clusterConfigDirPath),
          ""
        );
      }
      files.items.push(data);
    }
    return files;
  } catch (e) {
    console.error(e);
  }
}

export async function loadValuesAsObjectList(path) {
  let filesPath = upath.normalizeSafe(path);
  try {
    let files = []
    for await (const file of this.getFiles(filesPath)) {
      let data = YAML.parse(await fs.readFile(file, "utf8"));
      let filePath = upath.normalizeSafe(file);
      const {name, ext} = upath.parse(filePath)
      files.push({key: name, value: data});
    }
    return files;
  } catch (e) {
    console.error(e);
  }
}
export async function loadValuesAsArray(path) {
  let filesPath = upath.normalizeSafe(path);
  try {
    let files = []
    for await (const file of this.getFiles(filesPath)) {
      let data = YAML.parse(await fs.readFile(file, "utf8"));
      let filePath = upath.normalizeSafe(file);
      const {name, ext} = upath.parse(filePath)
      files.push(data);
    }
    return files;
  } catch (e) {
    console.error(e);
  }
}
export async function* getFiles(dir) {
  const dirents = await fs.readdir(dir, { withFileTypes: true });
  for (const dirent of dirents) {
    const res = path.resolve(dir, dirent.name);
    if (dirent.isDirectory()) {
      yield* getFiles(res);
    } else {
      yield res;
    }
  }
}
export async function runClusterScriptAsync(script, args, env = {}) {
  let scriptsPath = `${path.resolve(`${require.main.filename}/../../scripts`)}`;
  let scriptPath = `${path.join(scriptsPath, script)}`;

  let output;

  try {
    output = await execa(scriptPath, args);
  } catch (error) {
    console.log(error);
  }
  return output;
}

export async function jq(filter, path, options) {
  return new Promise((resolve, reject) => {
    nodejq
      .run(filter, path, options)
      .then((output) => {
        resolve(output);
      })
      .catch((err) => {
        reject(err);
      });
  });
}

export async function testKubernetesManifest(name) {
  let lint;
  try {
    lint = await runClusterScript("src/test/lint-manifest.sh", [name]);
  } catch (error) {
    console.error(error);
  }

  let audit;
  try {
    audit = await runClusterScript("src/test/audit-manifest.sh", [name]);
  } catch (error) {
    console.error(error);
  }

  let score;
  try {
    score = await runClusterScript("src/test/score-manifest.sh", [name]);
  } catch (error) {
    console.error(error);
  }

  let validate;
  try {
    validate = await runClusterScript("src/test/validate-manifest.sh", [name]);
  } catch (error) {
    console.error(error);
  }

  let conftest;
  try {
    conftest = await runClusterScript("src/test/conftest-manifest.sh", [name]);
  } catch (error) {
    console.error(error);
  }

  return {
    lint: lint,
    audit: audit,
    score: score,
    validate: validate,
    conftest: conftest,
  };
}

// Args parsing stuff
// let newArgs = []
// const split = flags.args.split(" ")
// for(let i in split) {
//   const arg = split[i]
//   const splitArg = arg.split('=')
//   const param = splitArg[0]
//   const value = splitArg[1]

//   const newParam = camelCase(param)
//   const newArg = [ `--${newParam}`,value].join(' ')
//   newArgs.push(newArg)
// }

// let newArgsString = newArgs.join(" ")

// console.log(newArgsString)
// console.log(argv)
//

//
export function fileExists(path: any) {
  const exists = fs.existsSync(path);
  return exists;
}

export async function fuzzySearch(
  values: Array<string>,
  term: string
): Promise<Array<string>> {
  console.log(typeof term);
  let fuzzy = FuzzySet(values);
  let matches = fuzzy.get(term);

  let results = [];
  if (matches) {
    for (const match of matches) {
      results.push(match[1]);
    }
  }

  return results;
}

export async function kubectl(command: string) {
  return await this.cliStream("kubectl", command.split(" "), { defaultExecaOptions });
}

export async function kubectljson(command: string) {
  return await this.cliStream("kubectl", [...(command.split(" ")), "-o", "json"], { defaultExecaOptions });
}

export async function kubectljs(command: string) {
  return JSON.parse((await this.cliStream("kubectl", [...(command.split(" ")), "-o", "json"], { defaultExecaOptions })).stdout);
}

export async function kubectljsexec(argv, flags = []) {
  let verb = argv.shift()
  let kind = argv.shift()
  let expr = [verb, kind, ...argv]
  return JSON.parse((await this.cliStream("kubectl", [...flags, ...expr], { defaultExecaOptions })).stdout);
}
