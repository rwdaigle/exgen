defmodule Mix.Tasks.Exgen.New do
  use Mix.Task
  import Mix.Exgen

  @shortdoc "Generate a new project from a template"

  @moduledoc """
  Generate a new project from an Exgen template

      $ mix exgen.new ./new_app https://github.com/rwdaigle/exgen-plug-default.git
  """
  def run(args) do
    %{files: files, context: context} = parse_args(args)
    files |> Enum.each(&render(&1, context))
  end

  defp render(%{template: template, target: target}, context) do
    rendered = template |> EEx.eval_file(context)
    Mix.Generator.create_file(target, rendered)
  end

  defp parse_args(args) do

    switches = [template: :string]
    {opts, args, _} = OptionParser.parse(args, switches: switches, aliases: [t: :template])

    default_opts = [template: "default"]
    opts = Keyword.merge(default_opts, opts)

    with app_path <- Enum.at(args, 0),
         app_name <- Path.basename(app_path),
         module <- inflect(app_name),
         template <- opts[:template] do

      files = template_path(template) |> template_files(app_path, app_name)

      %{
        files: files,
        context: [app_name: app_name, module: module]
      }
    end
  end

  defp template_path(template) do
    cond do
      String.ends_with?(template, ".git") ->
        tmp_dir = in_tmp fn -> System.cmd("git", ["clone", template, "exgen"]) end
        "#{tmp_dir}/exgen"
      true -> template
    end
  end

  defp template_files(template_path, target_root, app_name) do
    template_path
    |> ls_r
    |> Enum.filter(fn(file) -> !String.contains?(file, ".git/") end)
    |> Enum.map(fn(file) -> %{template: file, target: target_file(file, template_path, target_root, app_name)} end)
  end

  defp target_file(template_file, template_path, target_root, app_name) do
    template_file
    |> String.replace_prefix(template_path, target_root)
    |> String.replace("app_name", app_name)
  end

  defp inflect(name) do
    name
    |> String.split("_")
    |> Enum.map(&String.capitalize(&1))
    |> Enum.join("")
  end

end
