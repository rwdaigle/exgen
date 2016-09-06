defmodule Mix.Exgen do

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

  def in_tmp(function) do
    subdir = :crypto.rand_bytes(10) |> Base.hex_encode32
    tmp_path = Path.join(System.tmp_dir!, subdir)
    File.mkdir_p! tmp_path
    File.cd! tmp_path, function
    tmp_path
  end
end
