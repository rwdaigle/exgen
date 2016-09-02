# PlugTasks

A set of Mix tasks to quickly generate Plug-based applications in Elixir that attempt to recreate a Sinatra-like, lightweight, web experience.

While the goal is to eventually provide more customizable options/templates that suit a variety of use-cases, the current target is merely to quickly create a well structured, minimal, JSON-API based, web service.

## Installation

Install the plug tasks Mix archive:

```bash
$ mix archive.install https://github.com/rwdaigle/plug_tasks/raw/master/archives/plug_tasks-0.1.0.ez
```

The tasks will then be available via Mix:

```bash
$ mix -h | grep "plug."
mix plug.generate     # Generate a simple plug app
```

## Testing

Run automated tests:

```bash
$ mix test
```

You can also manually test the tasks by installing the archive locally:

```bash
$ mix do archive.build, archive.install
$ mkdir ~/tmp/test_app
$ cd ~/tmp/test_app
$ mix plug.generate test_app
```

## Release

Plug tasks are distributed as a mix archive. Build the archive with:

```bash
$ mix archive.build
$ mv plug_tasks-*.ez archives/
```
