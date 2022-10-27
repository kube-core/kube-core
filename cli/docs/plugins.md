`kube-core plugins`
===================

List installed plugins.

* [`kube-core plugins`](#kube-core-plugins)
* [`kube-core plugins:install PLUGIN...`](#kube-core-pluginsinstall-plugin)
* [`kube-core plugins:inspect PLUGIN...`](#kube-core-pluginsinspect-plugin)
* [`kube-core plugins:install PLUGIN...`](#kube-core-pluginsinstall-plugin-1)
* [`kube-core plugins:link PLUGIN`](#kube-core-pluginslink-plugin)
* [`kube-core plugins:uninstall PLUGIN...`](#kube-core-pluginsuninstall-plugin)
* [`kube-core plugins:uninstall PLUGIN...`](#kube-core-pluginsuninstall-plugin-1)
* [`kube-core plugins:uninstall PLUGIN...`](#kube-core-pluginsuninstall-plugin-2)
* [`kube-core plugins update`](#kube-core-plugins-update)

## `kube-core plugins`

List installed plugins.

```
USAGE
  $ kube-core plugins [--core]

FLAGS
  --core  Show core plugins.

DESCRIPTION
  List installed plugins.

EXAMPLES
  $ kube-core plugins
```

_See code: [@oclif/plugin-plugins](https://github.com/oclif/plugin-plugins/blob/v2.0.11/src/commands/plugins/index.ts)_

## `kube-core plugins:install PLUGIN...`

Installs a plugin into the CLI.

```
USAGE
  $ kube-core plugins:install PLUGIN...

ARGUMENTS
  PLUGIN  Plugin to install.

FLAGS
  -f, --force    Run yarn install with force flag.
  -h, --help     Show CLI help.
  -v, --verbose

DESCRIPTION
  Installs a plugin into the CLI.

  Can be installed from npm or a git url.

  Installation of a user-installed plugin will override a core plugin.

  e.g. If you have a core plugin that has a 'hello' command, installing a user-installed plugin with a 'hello' command
  will override the core plugin implementation. This is useful if a user needs to update core plugin functionality in
  the CLI without the need to patch and update the whole CLI.

ALIASES
  $ kube-core plugins add

EXAMPLES
  $ kube-core plugins:install myplugin 

  $ kube-core plugins:install https://github.com/someuser/someplugin

  $ kube-core plugins:install someuser/someplugin
```

## `kube-core plugins:inspect PLUGIN...`

Displays installation properties of a plugin.

```
USAGE
  $ kube-core plugins:inspect PLUGIN...

ARGUMENTS
  PLUGIN  [default: .] Plugin to inspect.

FLAGS
  -h, --help     Show CLI help.
  -v, --verbose

DESCRIPTION
  Displays installation properties of a plugin.

EXAMPLES
  $ kube-core plugins:inspect myplugin
```

## `kube-core plugins:install PLUGIN...`

Installs a plugin into the CLI.

```
USAGE
  $ kube-core plugins:install PLUGIN...

ARGUMENTS
  PLUGIN  Plugin to install.

FLAGS
  -f, --force    Run yarn install with force flag.
  -h, --help     Show CLI help.
  -v, --verbose

DESCRIPTION
  Installs a plugin into the CLI.

  Can be installed from npm or a git url.

  Installation of a user-installed plugin will override a core plugin.

  e.g. If you have a core plugin that has a 'hello' command, installing a user-installed plugin with a 'hello' command
  will override the core plugin implementation. This is useful if a user needs to update core plugin functionality in
  the CLI without the need to patch and update the whole CLI.

ALIASES
  $ kube-core plugins add

EXAMPLES
  $ kube-core plugins:install myplugin 

  $ kube-core plugins:install https://github.com/someuser/someplugin

  $ kube-core plugins:install someuser/someplugin
```

## `kube-core plugins:link PLUGIN`

Links a plugin into the CLI for development.

```
USAGE
  $ kube-core plugins:link PLUGIN

ARGUMENTS
  PATH  [default: .] path to plugin

FLAGS
  -h, --help     Show CLI help.
  -v, --verbose

DESCRIPTION
  Links a plugin into the CLI for development.

  Installation of a linked plugin will override a user-installed or core plugin.

  e.g. If you have a user-installed or core plugin that has a 'hello' command, installing a linked plugin with a 'hello'
  command will override the user-installed or core plugin implementation. This is useful for development work.

EXAMPLES
  $ kube-core plugins:link myplugin
```

## `kube-core plugins:uninstall PLUGIN...`

Removes a plugin from the CLI.

```
USAGE
  $ kube-core plugins:uninstall PLUGIN...

ARGUMENTS
  PLUGIN  plugin to uninstall

FLAGS
  -h, --help     Show CLI help.
  -v, --verbose

DESCRIPTION
  Removes a plugin from the CLI.

ALIASES
  $ kube-core plugins unlink
  $ kube-core plugins remove
```

## `kube-core plugins:uninstall PLUGIN...`

Removes a plugin from the CLI.

```
USAGE
  $ kube-core plugins:uninstall PLUGIN...

ARGUMENTS
  PLUGIN  plugin to uninstall

FLAGS
  -h, --help     Show CLI help.
  -v, --verbose

DESCRIPTION
  Removes a plugin from the CLI.

ALIASES
  $ kube-core plugins unlink
  $ kube-core plugins remove
```

## `kube-core plugins:uninstall PLUGIN...`

Removes a plugin from the CLI.

```
USAGE
  $ kube-core plugins:uninstall PLUGIN...

ARGUMENTS
  PLUGIN  plugin to uninstall

FLAGS
  -h, --help     Show CLI help.
  -v, --verbose

DESCRIPTION
  Removes a plugin from the CLI.

ALIASES
  $ kube-core plugins unlink
  $ kube-core plugins remove
```

## `kube-core plugins update`

Update installed plugins.

```
USAGE
  $ kube-core plugins update [-h] [-v]

FLAGS
  -h, --help     Show CLI help.
  -v, --verbose

DESCRIPTION
  Update installed plugins.
```
