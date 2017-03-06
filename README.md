# Exgen

Quickly generate Elixir apps from templates.

```bash
$ mix exgen.new some_app -t https://github.com/rwdaigle/exgen-plug-simple.git --app-name some_app --module SomeApp
* creating some_app/lib/some_app.ex
* creating some_app/lib/some_app/router.ex
```

## Overview

Templates are just [EEx](http://elixir-lang.org/docs/stable/eex/EEx.html) files that are evaluated at runtime. A simple template might be a single file with a variable substitution in EEx form:

```elixir
defmodule <%= module %>.Router do
end
```

Use Exgen's simple CLI to create a new app from this template:

```bash
$ mix exgen.new target_dir -t /path/to/template --module MyApp
```

Which will create a single file in the `target_dir` with the following contents:

```elixir
defmodule MyApp.Router do
end
```

## Installation

Exgen is distributed as a set of Mix tasks (much like Phoenix generators). Install them via Mix:

```bash
$ mix archive.install https://github.com/rwdaigle/exgen/raw/master/archives/exgen-0.5.1.ez
```

The tasks will then be available in Mix under the `exgen` namespace:

```bash
$ mix -h | grep "exgen."
mix exgen.new     # Generate a new project from a template
```

## Usage

Exgen operates by fetching a templatized app from a remote git repo or a local source. For instance, to quickly generate a basic Plug web app from this [template](https://github.com/rwdaigle/exgen-plug-simple):

```bash
$ mix exgen.new some_app -t https://github.com/rwdaigle/exgen-plug-simple.git --app-name some_app --module SomeApp
* creating some_app/lib/some_app.ex
* creating some_app/lib/some_app/router.ex
```

If you have an app template on your local filesystem you can just point to its path:

```bash
$ mix exgen.new some_app -t ~/dev/exgen-templates/exgen-plug-simple --app-name some_app --module SomeApp
* creating some_app/lib/some_app.ex
* creating some_app/lib/some_app/router.ex
```

Any variables needed by the template can be passed in from the CLI using switches. So if a template requires the `app_name` and `module` variables, use the `--app-name` and `--module` switches as above (switches are automatically underscored before being exposed to the template EEx context).

## Creating templates

For easy consistency and recognition, templates should be named with the following structure: `exgen-category-purpose`. For instance, a simple web app using only Plug is called `exgen-plug-simple`.

A template is just a set of EEx files with `<%= variable %>` statements in the file bodies (and even the file names themselves).

```text
|- <%= app_name %>.ex
|- mix.exs
|- <%= app_name %>
  |- router.ex
```

This template generated with the `--app-name my_app` switch will result in the following file structure:

```text
|- my_app.ex
|- mix.exs
|- my_app
  |- router.ex
```

## Templates

The following exgen templates are available from the community:

_If you would like yours listed here, edit this file and submit a PR_

App | Command w/ switches
----|--------------------
[Simple Plug web app](https://github.com/rwdaigle/exgen-plug-simple) | `$ mix exgen.new -t https://github.com/rwdaigle/exgen-plug-simple.git --app-name my_app --module MyApp`

## Contributing

### Testing

Run automated tests:

```bash
$ mix test
```

You can also manually test the tasks by installing the archive locally:

```bash
$ mix do archive.build, archive.install
```

### Release

Exgen is distributed as a mix archive. Build the archive with:

```bash
$ mix archive.build
$ mv exgen-*.ez archives/
```

## Todo

Some things I'd like to add include:

* Support testing workflow for template authors
* Silence git output (in tests at least)
* Use test tags to segment tests by remote/local

## Contributors

Code contributors include:

* [jknipp](https://github.com/jknipp)

## Changelog

### 0.5.2

* Support dynamic switch in Elixir 1.4
