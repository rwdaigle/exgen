ExUnit.start()

defmodule MixHelper do
  import ExUnit.Assertions

  def assert_rendered_template(rendered_path, template_path, context) do
    rendered = File.read!(rendered_path)
    template = render(Path.expand("../priv/templates/#{template_path}", __DIR__), context)
    assert rendered == template
  end

  defp render(path, context) do
    EEx.eval_file(path, context)
  end
end
