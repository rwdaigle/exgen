defmodule Mix.Exgen do

  def ls_r(path \\ ".") do
    cond do
      File.regular?(path) -> [path]
      File.dir?(path) ->
        File.ls!(path)
        |> Enum.map(&Path.join(path, &1))
        |> Enum.map(&ls_r/1)
        |> Enum.concat
      true -> []
    end
  end

  def in_tmp(function) do
    subdir = :crypto.strong_rand_bytes(10) |> Base.hex_encode32
    tmp_path = Path.join(System.tmp_dir!, subdir)
    File.mkdir_p! tmp_path
    File.cd! tmp_path, function
    tmp_path
  end
end
