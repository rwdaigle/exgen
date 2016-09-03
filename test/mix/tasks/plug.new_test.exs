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
        expected_context = [app_name: "some_app", module: "SomeApp"]
        assert_rendered_template("some_app/mix.exs", "new/default/mix.exs", expected_context)
        assert_rendered_template("some_app/lib/some_app.ex", "new/default/lib/app_name.ex", expected_context)
        assert_rendered_template("some_app/lib/some_app/router.ex", "new/default/lib/app_name/router.ex", expected_context)
      end
    end

    test "generates default app in relative dir" do
      in_tmp fn ->
        capture_io fn -> Mix.Tasks.Plug.New.run ["./test/some_app"] end
        expected_context = [app_name: "some_app", module: "SomeApp"]
        assert_rendered_template("test/some_app/mix.exs", "new/default/mix.exs", expected_context)
        assert_rendered_template("test/some_app/lib/some_app.ex", "new/default/lib/app_name.ex", expected_context)
        assert_rendered_template("test/some_app/lib/some_app/router.ex", "new/default/lib/app_name/router.ex", expected_context)
      end
    end
  end

  describe "plug.new -t default" do

    test "generates default app in current dir" do
      in_tmp fn ->
        capture_io fn -> Mix.Tasks.Plug.New.run ["some_app"] end
        expected_context = [app_name: "some_app", module: "SomeApp"]
        assert_rendered_template("some_app/mix.exs", "new/default/mix.exs", expected_context)
        assert_rendered_template("some_app/lib/some_app.ex", "new/default/lib/app_name.ex", expected_context)
        assert_rendered_template("some_app/lib/some_app/router.ex", "new/default/lib/app_name/router.ex", expected_context)
      end
    end

    test "generates default app in relative dir" do
      in_tmp fn ->
        capture_io fn -> Mix.Tasks.Plug.New.run ["./test/some_app"] end
        expected_context = [app_name: "some_app", module: "SomeApp"]
        assert_rendered_template("test/some_app/mix.exs", "new/default/mix.exs", expected_context)
        assert_rendered_template("test/some_app/lib/some_app.ex", "new/default/lib/app_name.ex", expected_context)
        assert_rendered_template("test/some_app/lib/some_app/router.ex", "new/default/lib/app_name/router.ex", expected_context)
      end
    end
  end

  describe "plug.new -t json_api" do

    test "generates json_api app in current dir" do
      in_tmp fn ->
        capture_io fn -> Mix.Tasks.Plug.New.run ["some_app", "-t", "json_api"] end
        expected_context = [app_name: "some_app", module: "SomeApp"]
        assert_rendered_template("some_app/mix.exs", "new/json_api/mix.exs", expected_context)
        assert_rendered_template("some_app/lib/some_app.ex", "new/json_api/lib/app_name.ex", expected_context)
        assert_rendered_template("some_app/lib/some_app/router.ex", "new/json_api/lib/app_name/router.ex", expected_context)
        assert_rendered_template("some_app/lib/some_app/routers/api_v1.ex", "new/json_api/lib/app_name/routers/api_v1.ex", expected_context)
      end
    end

    test "generates json_api app in relative dir" do
      in_tmp fn ->
        capture_io fn -> Mix.Tasks.Plug.New.run ["./test/some_app", "-t", "json_api"] end
        expected_context = [app_name: "some_app", module: "SomeApp"]
        assert_rendered_template("test/some_app/mix.exs", "new/json_api/mix.exs", expected_context)
        assert_rendered_template("test/some_app/lib/some_app.ex", "new/json_api/lib/app_name.ex", expected_context)
        assert_rendered_template("test/some_app/lib/some_app/router.ex", "new/json_api/lib/app_name/router.ex", expected_context)
        assert_rendered_template("test/some_app/lib/some_app/routers/api_v1.ex", "new/json_api/lib/app_name/routers/api_v1.ex", expected_context)
      end
    end
  end
end
