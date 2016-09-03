defmodule Mix.Tasks.Plug.New do
  use Mix.Task

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

  defp ls_r(path), do: ls_r(path, File.ls!(path), [])
  defp ls_r(path, [], acc), do: acc
  defp ls_r(path, files, acc) do
    regular_files =
      files
      |> Enum.map(fn(file) -> Path.expand(file, path) end)
      |> Enum.filter(&File.regular?/1)

    sub_files =
      files
      |> Enum.map(fn(file) -> Path.expand(file, path) end)
      |> Enum.filter(&File.dir?/1)
      |> Enum.map(fn(subdir) -> ls_r(subdir, File.ls!(subdir), acc) end)
      |> Enum.reduce([], fn(subfiles, acc) -> Enum.into(acc, subfiles) end)

    acc
    |> Enum.into(sub_files)
    |> Enum.into(regular_files)
  end

  defp inflect(name) do
    name
    |> String.split("_")
    |> Enum.map(&String.capitalize(&1))
    |> Enum.join("")
  end

end
