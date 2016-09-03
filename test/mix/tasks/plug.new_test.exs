defmodule Mix.Tasks.Plug.NewTest do

  use ExUnit.Case
  import MixHelper

  setup do
    Mix.Task.clear
    :ok
  end

  test "generate simple app in current dir" do

    in_tmp "new-app", fn ->

      app_name = "some_app"
      Mix.Tasks.Plug.New.run [app_name]

      in_dir app_name, fn ->
        assert_file "lib/some_app.ex", fn file ->
          template_path = Path.expand("../../../priv/templates/new/app.ex", __DIR__)
          assert file == render(template_path, [module: "SomeApp"])
        end
      end
    end
  end

  test "generate app in relative dir" do

    in_tmp "new-app", fn ->

      dir = "./test/some_app"
      Mix.Tasks.Plug.New.run [dir]

      in_dir dir, fn ->
        assert_file "lib/some_app.ex", fn file ->
          template_path = Path.expand("../../../priv/templates/new/app.ex", __DIR__)
          assert file == render(template_path, [module: "SomeApp"])
        end
      end
    end
  end

  defp render(path, context) do
    EEx.eval_file(path, context)
  end
end
