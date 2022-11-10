import BaseCommand from "./base";

async function read(stream: NodeJS.ReadStream) {
  const chunks: Uint8Array[] = []
  for await (const chunk of stream) chunks.push(chunk as Uint8Array)
  return Buffer.concat(chunks).toString('utf8')
}

export default abstract class StdinCommand extends BaseCommand {

  static stdin: string

  static flags = {}

  async init() {
    await super.init()
    StdinCommand.stdin = await read(process.stdin)
  }
}
