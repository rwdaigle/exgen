defmodule Mix.Tasks.Exgen.New do
  use Mix.Task
  import Mix.Exgen
  alias Exgen.Command

  @shortdoc "Generate a new project from a template"

  @moduledoc """
  Generate a new project from an Exgen template

      $ mix exgen.new ./new_app https://github.com/rwdaigle/exgen-plug-default.git
  """
  def run(args) do
    with {:ok, target, opts} <- parse_args(args),
         {:ok, template_path} <- resolve_template(opts[:template]),
         {:ok, command} <- Command.load(template_path, target, opts) do
      command |> Command.New.run
    end
  end

  defp parse_args(args) do

    switches = [template: :string]
    {opts, args, _} = OptionParser.parse(args, switches: switches, aliases: [t: :template])

    default_opts = []
    opts = Keyword.merge(default_opts, opts)
    target = Enum.at(args, 0)

    {:ok, target, opts}
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
