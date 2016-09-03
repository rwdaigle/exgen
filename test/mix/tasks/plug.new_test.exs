defmodule Mix.Tasks.Plug.NewTest do

  use ExUnit.Case, async: true
  import MixHelper
  import ExUnit.CaptureIO

  setup do
    Mix.Task.clear
    :ok
  end

  describe "plug.new" do

    test "generates default app in current dir" do
      in_tmp fn ->
        capture_io fn -> Mix.Tasks.Plug.New.run ["some_app"] end
        assert_rendered_template("some_app/lib/some_app.ex", "default/new/app.ex", [module: "SomeApp"])
        assert_rendered_template("some_app/lib/some_app/router.ex", "default/new/router.ex", [module: "SomeApp"])
      end
    end

    test "generates default app in relative dir" do
      in_tmp fn ->
        capture_io fn -> Mix.Tasks.Plug.New.run ["./test/some_app"] end
        assert_rendered_template("test/some_app/lib/some_app.ex", "default/new/app.ex", [module: "SomeApp"])
        assert_rendered_template("test/some_app/lib/some_app/router.ex", "default/new/router.ex", [module: "SomeApp"])
      end
    end
  end

  describe "plug.new -t default" do

    test "generates default app in current dir" do
      in_tmp fn ->
        capture_io fn -> Mix.Tasks.Plug.New.run ["some_app", "-t", "default"] end
        assert_rendered_template("some_app/lib/some_app.ex", "default/new/app.ex", [module: "SomeApp"])
        assert_rendered_template("some_app/lib/some_app/router.ex", "default/new/router.ex", [module: "SomeApp"])
      end
    end

    test "generates default app in relative dir" do
      in_tmp fn ->
        capture_io fn -> Mix.Tasks.Plug.New.run ["./test/some_app", "-t", "default"] end
        assert_rendered_template("test/some_app/lib/some_app.ex", "default/new/app.ex", [module: "SomeApp"])
        assert_rendered_template("test/some_app/lib/some_app/router.ex", "default/new/router.ex", [module: "SomeApp"])
      end
    end
  end

  describe "plug.new -t json_api" do

    test "generates json_api app in current dir" do
      in_tmp fn ->
        capture_io fn -> Mix.Tasks.Plug.New.run ["some_app", "-t", "json_api"] end
        assert_rendered_template("some_app/lib/some_app.ex", "json_api/new/app.ex", [module: "SomeApp"])
        assert_rendered_template("some_app/lib/some_app/router.ex", "json_api/new/router.ex", [module: "SomeApp"])
      end
    end

    test "generates json_api app in relative dir" do
      in_tmp fn ->
        capture_io fn -> Mix.Tasks.Plug.New.run ["./test/some_app", "-t", "json_api"] end
        assert_rendered_template("test/some_app/lib/some_app.ex", "json_api/new/app.ex", [module: "SomeApp"])
        assert_rendered_template("test/some_app/lib/some_app/router.ex", "json_api/new/router.ex", [module: "SomeApp"])
      end
    end
  end
end
