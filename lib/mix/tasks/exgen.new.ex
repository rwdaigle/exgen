defmodule Mix.Tasks.Exgen.New do
  use Mix.Task
  import Mix.Exgen
  import Exgen.Exfile

  @shortdoc "Generate a new project from a template"

  @moduledoc """
  Generate a new project from an Exgen template

      $ mix exgen.new ./new_app https://github.com/rwdaigle/exgen-plug-default.git
  """
  def run(args) do
    {:ok, target, opts} = parse_args(args)
    {:ok, template_path} = resolve_template(opts[:template])
    {:ok, exfile} = exfile(template_path, target, opts)

    template_path
    |> ls_r
    |> Enum.filter(fn(template_file) -> !String.contains?(template_file, ".git/") end)
    |> Enum.filter(fn(template_file) -> !String.ends_with?(template_file, "exgen.exs") end)
    |> Enum.map(fn(template_file) -> [template_file, target_file(exfile, template_file)] end)
    |> Enum.each(fn([template_file, target_file]) -> render(template_file, target_file, exfile.context) end)
  end

  defp parse_args(args) do

    switches = [template: :string]
    {opts, args, _} = OptionParser.parse(args, switches: switches, aliases: [t: :template])

    default_opts = []
    opts = Keyword.merge(default_opts, opts)
    target = Enum.at(args, 0)

    {:ok, target, opts}
  end

  defp render(template_file, target_file, context) do
    rendered = template_file |> EEx.eval_file(context)
    Mix.Generator.create_file(target_file, rendered)
  end

  defp resolve_template(template) do
    cond do
      String.ends_with?(template, ".git") ->
        tmp_dir = in_tmp fn -> System.cmd("git", ["clone", template, "exgen"]) end
        {:ok, "#{tmp_dir}/exgen"}
      true -> {:ok, template}
    end
  end
end
