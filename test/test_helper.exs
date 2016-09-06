ExUnit.start()

defmodule MixHelper do

  import ExUnit.Assertions
  import Mix.Exgen

  def assert_rendered_template(rendered_path, template_path, context) do
    rendered = File.read!(rendered_path)
    template = render(template_path, context)
    assert rendered == template
  end

  def git_clone(url) do
    tmp_dir = in_tmp fn -> System.cmd("git", ["clone", url, "exgen-test"]) end
    "#{tmp_dir}/exgen-test"
  end

  defp render(path, context) do
    EEx.eval_file(path, context)
  end
end
