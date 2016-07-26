ExUnit.start()

# From Phoenix mix task test helper
defmodule MixHelper do
  import ExUnit.Assertions

  def in_tmp(which, function) do
    path = Path.join(System.tmp_dir!, which)
    File.rm_rf! path
    File.mkdir_p! path
    File.cd! path, function
  end

  def assert_file(file) do
    assert File.regular?(file), "Expected #{file} to exist, but does not"
  end

  def assert_file(file, match) do
    cond do
      is_list(match) ->
        assert_file file, &(Enum.each(match, fn(m) -> assert &1 =~ m end))
      is_binary(match) or Regex.regex?(match) ->
        assert_file file, &(assert &1 =~ match)
      is_function(match, 1) ->
        assert_file(file)
        match.(File.read!(file))
    end
  end
end
