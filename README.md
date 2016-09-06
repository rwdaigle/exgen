# Exgen

A framework for quickly generating Elixir projects from community, or private, templates.

## Installation

Install the set of Exgen mix tasks:

```bash
$ mix archive.install https://github.com/rwdaigle/exgen/raw/master/archives/exgen-0.4.0.ez
```

The tasks will then be available via Mix:

```bash
$ mix -h | grep "exgen."
mix exgen.new     # Generate a new project from a template
```

## Usage

Exgen operates by fetching a templatized app from a remote git repo or a local source. For instance, to quickly generate a basic Plug web app:

```bash
$ mix exgen.new ./some_app -t https://github.com/rwdaigle/exgen-plug-default.git
* creating some_app/lib/some_app.ex
* creating some_app/lib/some_app/router.ex
```

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

* Support dynamic contexts
* Make this a more general purpose generator library
* Use test tags to segment tests by remote/local
