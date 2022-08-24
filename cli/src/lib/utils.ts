import * as child from "child_process";
import { spawn, spawnSync } from "child_process";
import * as path from "path";
// import execa from "execa";
const execa = require('execa')

export async function cli(cmd, ...args) {
  try {
  const { stdout } = await execa(cmd, args);
  console.log(stdout);
  } catch(error) {
    console.log(error)
  }
}

export async function cliPipe(cmd, args, env = {}) {
  try {
    // let output = execa("env", args, {maxBuffer: 300_000_000, env: {HELM_DIFF_IGNORE_UNKNOWN_FLAGS: "true", extendEnv: false} })
    let output = execa(cmd, args, {maxBuffer: 300_000_000, env: env })
    output.stdout.pipe(process.stdout);
    output.stderr.pipe(process.stderr);
    // process.exit()
    return output
    } catch(error) {
      console.log(error)
    }

}

export async function runScript(script, args, env = {}) {
  let scriptsPath = `${path.resolve(
    `${require.main.filename}/../../../scripts`
  )}`;
  let scriptPath = `${path.join(scriptsPath, script)}`;
  let output

  try {
    output = await cliPipe(scriptPath, args, env)
  } catch(error) {
    console.log(error)
  }
  return output
}

export async function runCoreScript(script, args, env = {}) {
  let scriptsPath = `${path.resolve(
    `${require.main.filename}/../../../scripts`
  )}`;
  let scriptPath = `${path.join(scriptsPath, script)}`;
  let output

  try {
    output = await cliPipe(scriptPath, args, env)
  } catch(error) {
    console.log(error)
  }
  return output
}

export async function runCoreScriptAsync(script, args, env = {}) {
  let scriptsPath = `${path.resolve(
    `${require.main.filename}/../../../scripts`
  )}`;
  let scriptPath = `${path.join(scriptsPath, script)}`;

  let output

  try {
    output = await execa(scriptPath, args)
  } catch(error) {
    console.log(error)
  }
  return output
}

export async function runClusterScript(script, args, env = {}) {
  let scriptsPath = `${path.resolve(
    `${require.main.filename}/../../../scripts`
  )}`;
  let scriptPath = `${path.join(scriptsPath, script)}`;
  let output

  try {
    output = await cliPipe(scriptPath, args, env)
  } catch(error) {
    console.log(error)
  }
  return output
}

export async function runClusterTestScript(script, args, env = {}) {
  let scriptsPath = `${path.resolve(
    `${require.main.filename}/../../../scripts`
  )}`;
  let scriptPath = `${path.join(scriptsPath, script)}`;
  let output

  try {
    output = await cliPipe(scriptPath, args, env)
  } catch(error) {
    if(error.exitCode > 0) {
      if(process.env.LOG_LEVEL == "DEBUG" || process.env.LOG_LEVEL == "INSANE") {
        console.log(error)
      }
      process.exit(error.exitCode)
    }
  }
  return output
}

export async function runClusterScriptAsync(script, args, env = {}) {
  let scriptsPath = `${path.resolve(
    `${require.main.filename}/../../../scripts`
  )}`;
  let scriptPath = `${path.join(scriptsPath, script)}`;

  let output

  try {
    output = await execa(scriptPath, args)
  } catch(error) {
    console.log(error)
  }
  return output
}
export async function testKubernetesManifest(name) {

  let lint
  try {
    lint = await runClusterScript('src/test/lint-manifest.sh', [name])
  } catch(error) {
    console.error(error)
  }

  let audit
  try {
    audit = await runClusterScript('src/test/audit-manifest.sh', [name])
  } catch(error) {
    console.error(error)
  }

  let score
  try {
    score = await runClusterScript('src/test/score-manifest.sh', [name])
  } catch(error) {
    console.error(error)
  }

  let validate
  try {
    validate = await runClusterScript('src/test/validate-manifest.sh', [name])
  } catch(error) {
    console.error(error)
  }

  let conftest
  try {
    conftest = await runClusterScript('src/test/conftest-manifest.sh', [name])
  } catch(error) {
    console.error(error)
  }

  return {
    "lint": lint,
    "audit": audit,
    "score": score,
    "validate": validate,
    "conftest": conftest,
  }
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
