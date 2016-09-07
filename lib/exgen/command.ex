defmodule Exgen.Command do

  defstruct module: nil, template_path: nil, target_path: ".", opts: [], context: []
  alias Exgen.Command
  import Mix.Exgen

  def load(template_path, target_path, opts \\ []) do
    cond do
      File.exists?(template_path) ->
        command = %Command{template_path: template_path, target_path: target_path, opts: opts}
        command = if File.exists?(exfile_path = "#{template_path}/exgen.exs") do
          module = Kernel.ParallelCompiler.files([exfile_path]) |> Enum.at(0)
          context = module.context(command)
          %{command | module: module, context: context}
        end
        {:ok, command}
      true ->
        {:err, "Could not find #{template_path}"}
    end
  end
end
