defmodule Mix.PlugTasks do

  def ls_r(file) do
    cond do
      File.regular?(file) -> [file]
      File.dir?(file) ->
        File.ls!(file)
        |> Enum.map(&Path.expand(&1, file))
        |> Enum.map(&ls_r/1)
        |> Enum.reduce([], fn(files, acc) -> Enum.into(acc, files) end)
      true -> []
    end
  end
end
