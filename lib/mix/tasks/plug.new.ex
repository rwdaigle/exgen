defmodule Mix.Tasks.Plug.New do
  use Mix.Task
  import Mix.PlugTasks

  @shortdoc "Generate a simple plug app"

  @moduledoc """
  Generate a simple plug app

      $ mix plug.new ./new_app

  The default router is inflected from the application
  name.
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

    default_opts = [template: :default]
    opts = Keyword.merge(default_opts, opts)

    with app_path <- Enum.at(args, 0),
         app_name <- Path.basename(app_path),
         module <- inflect(app_name),
         template <- opts[:template] do

      files =
        Path.expand("../../../priv/templates/new/#{template}", __DIR__)
        |> template_files(app_path, app_name)

      %{
        files: files,
        context: [app_name: app_name, module: module]
      }
    end
  end

  defp template_files(template_path, target_root, app_name) do
    template_path
    |> ls_r
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
