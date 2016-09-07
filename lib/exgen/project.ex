defmodule Exgen.Project do

  defstruct target: ".", options: []
  alias Exgen.Project

  def target_base(%Project{target: target_path}) do
    target_path
    |> Path.basename
    |> String.replace("-", "_")
  end

  def module_name(project) do
    project
    |> target_base
    |> String.split("_")
    |> Enum.map(&String.capitalize(&1))
    |> Enum.join("")
  end
end
