defmodule Exgen.Command do

  defstruct module: nil, template_path: nil, target_path: ".", context: []
  alias Exgen.Command
  import Mix.Exgen

  def load(template_path, target_path, opts \\ []) do
    cond do
      File.exists?(template_path) ->
        command =
          %Command{template_path: template_path, target_path: target_path, context: opts_to_context(opts)}
          |> load_config
        {:ok, command}
      true ->
        {:err, "Could not find #{template_path}"}
    end
  end

  defp load_config(command) do
    cond do
      File.exists?(exfile_path = "#{command.template_path}/exgen.exs") ->
        module = Kernel.ParallelCompiler.files([exfile_path]) |> Enum.at(0)
        context = module.context(command) |> Keyword.merge(command.context)
        %{command | module: module, context: context}
      true -> command
    end
  end

  defp opts_to_context(opts) do
    opts
    |> Enum.map(fn({name, value}) -> {name |> underscore, value} end)
    |> Keyword.new
  end

  defp underscore(atom) when is_atom(atom), do: atom |> to_string |> underscore
  defp underscore(string) when is_binary(string) do
    string |> String.replace("-", "_") |> String.to_atom
  end
end
