defmodule Mix.Tasks.Plug.NewTest do

  use ExUnit.Case
  import MixHelper

  setup do
    Mix.Task.clear
    :ok
  end

  describe "plug.new" do

    test "generates default app in current dir" do
      in_tmp fn ->
        Mix.Tasks.Plug.New.run ["some_app"]
        assert_rendered_template("some_app/lib/some_app.ex", "default/new/app.ex", [module: "SomeApp"])
        assert_rendered_template("some_app/lib/some_app/router.ex", "default/new/router.ex", [module: "SomeApp"])
      end
    end

    test "generates default app in relative dir" do
      in_tmp fn ->
        Mix.Tasks.Plug.New.run ["./test/some_app"]
        assert_rendered_template("test/some_app/lib/some_app.ex", "default/new/app.ex", [module: "SomeApp"])
        assert_rendered_template("test/some_app/lib/some_app/router.ex", "default/new/router.ex", [module: "SomeApp"])
      end
    end
  end
end
