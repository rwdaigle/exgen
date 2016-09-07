defmodule Exgen.Command.New do
  import Mix.Exgen

  def run(command) do
    command.template_path
    |> ls_r
    |> Enum.filter(fn(template_file) -> !String.contains?(template_file, ".git/") end)
    |> Enum.filter(fn(template_file) -> !String.ends_with?(template_file, "exgen.exs") end)
    |> Enum.map(fn(template_file) -> [template_file, target_file(command, template_file)] end)
    |> Enum.each(fn([template_file, target_file]) -> render(template_file, target_file, command.context) end)
  end

  defp target_file(command, template_file_path) do
    target_file = template_file_path |> Path.relative_to(command.template_path)
    Path.join(command.target_path, target_file)
    |> command.module.target_file(command.context)
  end

  defp render(template_file, target_file, context) do
    rendered = template_file |> EEx.eval_file(context)
    Mix.Generator.create_file(target_file, rendered)
  end
end
