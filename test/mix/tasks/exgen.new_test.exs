defmodule Mix.Tasks.Exgen.NewTest do

  use ExUnit.Case
  import MixHelper
  import ExUnit.CaptureIO
  import Mix.Exgen

  setup do
    Mix.Task.clear
    :ok
  end

  describe "exgen.new from local template" do

    setup do
      {:ok, %{template: Path.expand("../../fixtures/templates/simple", __DIR__)}}
    end

    test "generates app in current dir", %{template: template} do
      in_tmp fn ->
        capture_io fn -> Mix.Tasks.Exgen.New.run ["some_app", "-t", template] end
        expected_context = [app_name: "some_app", module: "SomeApp"]
        assert_rendered_template("some_app/mix.exs", "#{template}/mix.exs", expected_context)
        assert_rendered_template("some_app/lib/some_app.ex", "#{template}/lib/app_name.ex", expected_context)
        assert_rendered_template("some_app/lib/some_app/router.ex", "#{template}/lib/app_name/router.ex", expected_context)
      end
    end

    test "generates app in relative dir", %{template: template} do
      in_tmp fn ->
        capture_io fn -> Mix.Tasks.Exgen.New.run ["./test/some_app", "-t", template] end
        expected_context = [app_name: "some_app", module: "SomeApp"]
        assert_rendered_template("test/some_app/mix.exs", "#{template}/mix.exs", expected_context)
        assert_rendered_template("test/some_app/lib/some_app.ex", "#{template}/lib/app_name.ex", expected_context)
        assert_rendered_template("test/some_app/lib/some_app/router.ex", "#{template}/lib/app_name/router.ex", expected_context)
      end
    end
  end

  describe "exgen.new from SSH git repo" do

    setup do
      url = "git@github.com:rwdaigle/exgen-plug-default.git"
      {:ok, %{url: url, template: git_clone(url)}}
    end

    test "generates app in current dir", %{url: url, template: template} do
      in_tmp fn ->
        capture_io fn -> Mix.Tasks.Exgen.New.run ["some_app", "-t", url] end
        expected_context = [app_name: "some_app", module: "SomeApp"]
        assert_rendered_template("some_app/mix.exs", "#{template}/mix.exs", expected_context)
        assert_rendered_template("some_app/lib/some_app.ex", "#{template}/lib/app_name.ex", expected_context)
        assert_rendered_template("some_app/lib/some_app/router.ex", "#{template}/lib/app_name/router.ex", expected_context)
      end
    end

    test "generates app in relative dir", %{url: url, template: template} do
      in_tmp fn ->
        capture_io fn -> Mix.Tasks.Exgen.New.run ["./test/some_app", "-t", url] end
        expected_context = [app_name: "some_app", module: "SomeApp"]
        assert_rendered_template("./test/some_app/mix.exs", "#{template}/mix.exs", expected_context)
        assert_rendered_template("./test/some_app/lib/some_app.ex", "#{template}/lib/app_name.ex", expected_context)
        assert_rendered_template("./test/some_app/lib/some_app/router.ex", "#{template}/lib/app_name/router.ex", expected_context)
      end
    end
  end

  describe "exgen.new from HTTP git repo" do

    setup do
      url = "https://github.com/rwdaigle/exgen-plug-default.git"
      {:ok, %{url: url, template: git_clone(url)}}
    end

    test "generates app in current dir", %{url: url, template: template} do
      in_tmp fn ->
        capture_io fn -> Mix.Tasks.Exgen.New.run ["some_app", "-t", url] end
        expected_context = [app_name: "some_app", module: "SomeApp"]
        assert_rendered_template("some_app/mix.exs", "#{template}/mix.exs", expected_context)
        assert_rendered_template("some_app/lib/some_app.ex", "#{template}/lib/app_name.ex", expected_context)
        assert_rendered_template("some_app/lib/some_app/router.ex", "#{template}/lib/app_name/router.ex", expected_context)
      end
    end

    test "generates app in relative dir", %{url: url, template: template} do
      in_tmp fn ->
        capture_io fn -> Mix.Tasks.Exgen.New.run ["./test/some_app", "-t", url] end
        expected_context = [app_name: "some_app", module: "SomeApp"]
        assert_rendered_template("./test/some_app/mix.exs", "#{template}/mix.exs", expected_context)
        assert_rendered_template("./test/some_app/lib/some_app.ex", "#{template}/lib/app_name.ex", expected_context)
        assert_rendered_template("./test/some_app/lib/some_app/router.ex", "#{template}/lib/app_name/router.ex", expected_context)
      end
    end
  end
end
