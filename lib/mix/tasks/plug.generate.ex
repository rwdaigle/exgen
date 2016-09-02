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
    %{files: files, context: context} = parse_args(args)
    files |> Enum.each(&render(&1, context))
  end

  defp render(%{template: template, target: target}, context) do
    Path.expand("../../../#{template}", __DIR__)
    |> EEx.eval_file(context)
    |> output(target)
  end

  defp output(contents, file_path) do
    Mix.Generator.create_file(file_path, contents)
  end

  defp parse_args(args) do
    app_name = args |> Enum.at(0)
    module = app_name |> inflect
    %{
      files: [
        %{template: "priv/templates/generate/app.ex", target: "lib/#{app_name}.ex"},
        %{template: "priv/templates/generate/router.ex", target: "lib/#{app_name}/router.ex"}
      ],
      context: [module: module]
    }
  end

  defp inflect(name) do
    name
    |> String.split("_")
    |> Enum.map(&String.capitalize(&1))
    |> Enum.join("")
  end

end
