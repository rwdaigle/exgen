# Exgen

Quickly generate Elixir apps from templates.

![Screengrab]()

Templates are just [EEx](http://elixir-lang.org/docs/stable/eex/EEx.html) files that are evaluated at runtime. So if you have a templated app:

```bash
$ ls
exgen.exs lib       mix.exs
```

And inside one of the files

## Installation

Exgen is distributed as a set of Mix tasks (much like Phoenix generators). Install them via Mix:

```bash
$ mix archive.install https://github.com/rwdaigle/exgen/raw/master/archives/exgen-0.5.0.ez
```

The tasks will then be available in Mix under the `exgen` namespace:

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

* Silence git output
* Use test tags to segment tests by remote/local
