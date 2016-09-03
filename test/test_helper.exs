ExUnit.start()

# From Phoenix mix task test helper
defmodule MixHelper do
  import ExUnit.Assertions

  def in_tmp(function) do
    subdir = :crypto.rand_bytes(10) |> Base.hex_encode32
    tmp_path = Path.join(System.tmp_dir!, subdir)
    File.mkdir_p! tmp_path
    File.cd! tmp_path, function
  end

  def assert_rendered_template(rendered_path, template_path, context) do
    rendered = File.read!(rendered_path)
    template = render(Path.expand("../priv/templates/#{template_path}", __DIR__), context)
    assert rendered == template
  end

  defp render(path, context) do
    EEx.eval_file(path, context)
  end
end
