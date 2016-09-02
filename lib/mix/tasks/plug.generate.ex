defmodule Mix.Tasks.Plug.Generate do
  use Mix.Task

  @shortdoc "Generate a simple plug app"

  @moduledoc """
  Generate a simple plug app

      $ mix plug.generate new_app

  The default router is inflected from the application
  name.
  """
  def run(args) do
    %{files: files, context: context, dir: dir} = parse_args(args)
    files |> Enum.each(&render(&1, context, dir))
  end

  defp render(%{template: template, target: target}, context, dir) do
    Path.expand("../../../#{template}", __DIR__)
    |> EEx.eval_file(context)
    |> output(dir, target)
  end

  defp output(contents, dir, rel_path) do
    Path.expand(rel_path, dir)
    |> Mix.Generator.create_file(contents)
  end

  defp parse_args(args) do
    app_path = args |> Enum.at(0)
    app_name = app_path |> Path.basename
    module = app_name |> inflect
    %{
      files: [
        %{template: "priv/templates/generate/app.ex", target: "lib/#{app_name}.ex"},
        %{template: "priv/templates/generate/router.ex", target: "lib/#{app_name}/router.ex"}
      ],
      context: [module: module],
      dir: app_path
    }
  end

  defp inflect(name) do
    name
    |> String.split("_")
    |> Enum.map(&String.capitalize(&1))
    |> Enum.join("")
  end

end
