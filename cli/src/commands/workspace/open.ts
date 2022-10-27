import { Command, Flags } from "@oclif/core";
import BaseCommand from "../../base";
import open from "open";
import * as path from "path";

import { getSystemErrorMap } from "util";

export default class WorkspaceOpen extends BaseCommand {
  static description = "Quickly open important URLs from your cluster.";

  static examples = [
    `
    $ kube-core workspace open # Opens first host on every ingress cluster-wide matching: -l workspace.kube-core.io/name=default
    $ kube-core workspace open logging # Opens first host on every ingress cluster-wide matching: -l workspace.kube-core.io/name=logging
    $ kube-core workspace open all # Opens first host on every ingress cluster-wide
    $ kube-core workspace open all -n integration  # Opens first host on every ingress in integration Namespace
    $ kube-core workspace open admin -n integration  # Opens first host on every ingress in integration Namespace matching: -l workspace.kube-core.io/name=admin
  `,
  ];

  static args = [];
  static flags = {
    namespace: Flags.string({
      char: "n",
      description: "namespace to use",
      hidden: false,
      multiple: false,
      default: "default",
      required: false,
    }),
  };

  static strict = false;

  async run(): Promise<void> {
    const { args, argv, flags } = await this.parse(WorkspaceOpen);

    let cmdArguments = ["get", "ingress", "-o", "json"];

    // Context
    if (this.clusterConfig.cluster.config.context) {
      cmdArguments.push(`--context`, this.clusterConfig.cluster.config.context);
    }

    // Namespace filter
    if (flags.namespace) {
      cmdArguments.push(`-n`, flags.namespace);
    }

    // Label Filter
    if (argv.length > 0 && argv[0] !== "all") {
      cmdArguments.push(`-l workspace.kube-core.io/name=${argv[0]}`);
    } else if (argv.length > 0 && argv[0] === "all") {
      /* TODO: Filter complete list */
    } else {
      cmdArguments.push(`-l workspace.kube-core.io/name=default`);
    }

    // Getting Ingress List
    const ingressResponse = await this.utils.cliQuiet("kubectl", cmdArguments);
    const ingressList = JSON.parse(ingressResponse.stdout);

    if (ingressList.items.length > 0) {
      // Parsing response
      let ingressConfigList = [];
      for (let i in ingressList.items) {
        const ingress = ingressList.items[i];
        let ingressConfig = {
          namespace: ingress.metadata.namespace,
          name: ingress.metadata.name,
          host: ingress.spec.rules[0].host,
        };
        ingressConfigList.push(ingressConfig);
      }

      for (let i = 0; i < ingressConfigList.length; i++) {
        const ingress = ingressConfigList[i];

        let options = {
          name: open.apps.chrome,
          arguments: [],
        };
        let openOptions = { wait: false, app: options };

        // The first tab to be opened generates a new window
        // The following tabs will be opened in the newly opened window
        if (i == 0) {
          openOptions.app.arguments = ["--new-window"];
          openOptions.wait = true;
        }

        await open(`https://${ingress.host}`, openOptions);
      }
    } else {
      console.log(
        "No workspace Ingress found. Use the label workspace.kube-core.io/name to create your workspaces."
      );
    }
  }
}
