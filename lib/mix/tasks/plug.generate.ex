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
    module =
      args
      |> Enum.at(0)
      |> inflect

    [module: module]
    |> render("app.ex")
    |> output("/tmp/my_app.ex")
  end

  defp render(context, file_name) do
    "priv/templates/generate/#{file_name}"
    |> EEx.eval_file(context)
  end

  defp output(contents, file_path) do
    # Mix.shell.info contents
    File.write!(file_path, contents)
  end

  defp inflect(name) do
    name
    |> String.split("_")
    |> Enum.map(&String.capitalize(&1))
    |> Enum.join("")
  end

end
