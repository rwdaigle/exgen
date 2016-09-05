# PlugTasks

A set of Mix tasks to quickly generate Plug-based applications in Elixir that attempt to recreate a Sinatra-like, lightweight, web experience.

While the goal is to eventually provide more customizable options/templates that suit a variety of use-cases, the current target is merely to quickly create a well structured, minimal, JSON-API based, web service.

## Installation

Install the plug tasks Mix archive:

```bash
$ mix archive.install https://github.com/rwdaigle/plug_tasks/raw/master/archives/plug_tasks-0.2.0.ez
```

The tasks will then be available via Mix:

```bash
$ mix -h | grep "plug."
mix plug.new     # Generate a simple plug app
```

## Usage

To generate a Plug app template, pass in the root app path. The app name will be inferred from the path.

```bash
$ mix plug.new ./some_app
* creating some_app/lib/some_app.ex
* creating some_app/lib/some_app/router.ex
```

## Testing

Run automated tests:

```bash
$ mix test
```

You can also manually test the tasks by installing the archive locally:

```bash
$ mix do archive.build, archive.install
```

## Release

Plug tasks are distributed as a mix archive. Build the archive with:

```bash
$ mix archive.build
$ mv plug_tasks-*.ez archives/
```

## Todo

Some things I'd like to add include:

* Allow for non-repo based templates (git repo, URL, local FS, etc...)
