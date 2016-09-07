defmodule Exgen.Util do

  def target_base(target_path) do
    target_path
    |> Path.basename
    |> String.replace("-", "_")
  end

  def module_name(target_path) do
    target_path
    |> target_base
    |> String.split("_")
    |> Enum.map(&String.capitalize(&1))
    |> Enum.join("")
  end
end
