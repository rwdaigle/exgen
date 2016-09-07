defmodule Web.Simple.Exfile do
  alias Exgen.Project

  def context(project) do
    [
      app_name: Project.target_base(project),
      module: Project.module_name(project)
    ]
  end

  def target_file(target_path, context) do
    target_path |> String.replace("app_name", context[:app_name])
  end
end
