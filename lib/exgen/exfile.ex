defmodule Exgen.Exfile do

  defstruct module: nil, template_path: nil, target_path: ".", opts: [], context: []
  alias Exgen.Project
  alias Exgen.Exfile

  def exfile(template_path, target_path, opts \\ []) do
    cond do
      File.exists?(template_path) ->
        exfile = %Exfile{template_path: template_path, target_path: target_path, opts: opts}
        exfile = if File.exists?(exfile_path = "#{template_path}/exgen.exs") do
          module = Kernel.ParallelCompiler.files([exfile_path]) |> Enum.at(0)
          context = module.context(%Project{target: target_path, options: opts})
          %{exfile | module: module, context: context}
        end
        {:ok, exfile}
      true ->
        {:error, "Could not find #{template_path}"}
    end
  end

  def target_file(exfile, template_file_path) do
    target_file = template_file_path |> Path.relative_to(exfile.template_path)
    Path.join(exfile.target_path, target_file)
    |> exfile.module.target_file(exfile.context)
  end
end
