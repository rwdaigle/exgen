defmodule Web.Simple.Exgen do
  alias Exgen.Command
  import Exgen.Util

  def context(%Command{target_path: target_path}) do
    [
      app_name: target_base(target_path),
      module: module_name(target_path)
    ]
  end

  def target_file(target_path, context) do
    target_path |> String.replace("app_name", context[:app_name])
  end
end
