# kube-core CLI
## Stability
>:warning: The CLI is currently in beta
## Getting Started
First, install all the requirements.
Then you can install the CLI with:

```bash
sudo apt install curl 
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
source ~/.bashrc
nvm install v18.8.0
nvm use v18.8.0
npm install -g @kube-core/cli
sudo chown -R $USER: $HOME/.nvm/versions/node/v18.8.0/lib/node_modules/
sudo chmod -R a+x $HOME/.nvm/versions/node/v18.8.0/lib/node_modules/
kube-core version
```

To upgrade it, you have to run: 

```bash
npm install -g @kube-core/cli
sudo chown -R $USER: $HOME/.nvm/versions/node/v18.8.0/lib/node_modules/
sudo chmod -R a+x $HOME/.nvm/versions/node/v18.8.0/lib/node_modules/
kube-core version
```

# Usage
<!-- usage -->
```sh-session
$ npm install -g @kube-core/cli
$ kube-core COMMAND
running command...
$ kube-core (--version)
@kube-core/cli/0.11.11 win32-x64 node-v18.12.0
$ kube-core --help [COMMAND]
USAGE
  $ kube-core COMMAND
...
```
<!-- usagestop -->
# Commands
<!-- commands -->
# Command Topics

* [`kube-core absorb`](docs/absorb.md) - Patch some resources with Helm metadata/labels, and import them quickly as local charts in kube-core.
* [`kube-core apply`](docs/apply.md) - Apply kube-core and cluster configuration.
* [`kube-core autocomplete`](docs/autocomplete.md) - display autocomplete installation instructions
* [`kube-core build`](docs/build.md) - Build kube-core and cluster configuration.
* [`kube-core dev`](docs/dev.md) - Tools for kube-core development.
* [`kube-core diff`](docs/diff.md) - Run a diff on a cluster.
* [`kube-core generate`](docs/generate.md) - Generate various resources.
* [`kube-core gitops`](docs/gitops.md) - Explore and manage your GitOps config
* [`kube-core help`](docs/help.md) - Display help for kube-core.
* [`kube-core import`](docs/import.md) - Import resources from a cluster.
* [`kube-core path`](docs/path.md) - Prints kube-core local path.
* [`kube-core plugins`](docs/plugins.md) - List installed plugins.
* [`kube-core scripts`](docs/scripts.md) - Search and execute available scripts.
* [`kube-core test`](docs/test.md) - Tests all config.
* [`kube-core values`](docs/values.md) - View and manage configuration values.
* [`kube-core version`](docs/version.md) - Prints kube-core version.
* [`kube-core workspace`](docs/workspace.md) - Quickly open important URLs from your cluster.

<!-- commandsstop -->
# Table of contents
<!-- toc -->
* [kube-core CLI](#kube-core-cli)
* [Usage](#usage)
* [Commands](#commands)
* [Command Topics](#command-topics)
* [Table of contents](#table-of-contents)
<!-- tocstop -->
