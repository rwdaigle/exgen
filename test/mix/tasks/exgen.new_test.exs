defmodule Mix.Tasks.Exgen.NewTest do

  use ExUnit.Case
  import MixHelper
  import ExUnit.CaptureIO
  import Mix.Exgen

  setup do
    Mix.Task.clear
    :ok
  end

  describe "exgen.new without config" do

    setup do
      {:ok, %{template: Path.expand("../../fixtures/templates/simple", __DIR__)}}
    end

    test "generates app in current dir", %{template: template} do
      in_tmp fn ->
        capture_io fn -> Mix.Tasks.Exgen.New.run ["some_app", "-t", template, "--app-name", "some_app", "--module", "SomeApp"] end
        context = [app_name: "some_app", module: "SomeApp"]
        assert_rendered_template("#{template}/mix.exs", "some_app/mix.exs", context)
        assert_rendered_template("#{template}/lib/<%= app_name %>.ex", "some_app/lib/some_app.ex", context)
        assert_rendered_template("#{template}/lib/<%= app_name %>/router.ex", "some_app/lib/some_app/router.ex",context)
      end
    end

    test "generates app in relative dir", %{template: template} do
      in_tmp fn ->
        capture_io fn -> Mix.Tasks.Exgen.New.run ["test/some_app", "-t", template, "--app-name", "some_app", "--module", "SomeApp"] end
        context = [app_name: "some_app", module: "SomeApp"]
        assert_rendered_template("#{template}/mix.exs", "test/some_app/mix.exs", context)
        assert_rendered_template("#{template}/lib/<%= app_name %>.ex", "test/some_app/lib/some_app.ex", context)
        assert_rendered_template("#{template}/lib/<%= app_name %>/router.ex", "test/some_app/lib/some_app/router.ex",context)
      end
    end
  end

  describe "exgen.new with config" do

    setup do
      {:ok, %{template: Path.expand("../../fixtures/templates/simple_with_config", __DIR__)}}
    end

    test "generates app in current dir", %{template: template} do
      in_tmp fn ->
        capture_io fn -> Mix.Tasks.Exgen.New.run ["some_app", "-t", template] end
        context = [app_name: "some_app", module: "SomeApp"]
        assert_rendered_template("#{template}/mix.exs", "some_app/mix.exs", context)
        assert_rendered_template("#{template}/lib/app_name.ex", "some_app/lib/some_app.ex", context)
        assert_rendered_template("#{template}/lib/app_name/router.ex", "some_app/lib/some_app/router.ex",context)
      end
    end
  end

  describe "exgen.new from SSH git repo" do

    setup do
      url = "git@github.com:rwdaigle/exgen-plug-simple.git"
      {:ok, %{url: url, template: git_clone(url)}}
    end

    test "generates app in current dir", %{url: url, template: template} do
      in_tmp fn ->
        capture_io fn -> Mix.Tasks.Exgen.New.run ["some_app", "-t", url, "--app-name", "some_app", "--module", "SomeApp"] end
        expected_context = [app_name: "some_app", module: "SomeApp"]
        assert_rendered_template("#{template}/mix.exs", "some_app/mix.exs", expected_context)
        assert_rendered_template("#{template}/lib/<%= app_name %>.ex", "some_app/lib/some_app.ex", expected_context)
        assert_rendered_template("#{template}/lib/<%= app_name %>/router.ex", "some_app/lib/some_app/router.ex", expected_context)
      end
    end
  end

  describe "exgen.new from HTTP git repo" do

    setup do
      url = "https://github.com/rwdaigle/exgen-plug-simple.git"
      {:ok, %{url: url, template: git_clone(url)}}
    end

    test "generates app in current dir", %{url: url, template: template} do
      in_tmp fn ->
        capture_io fn -> Mix.Tasks.Exgen.New.run ["some_app", "-t", url, "--app-name", "some_app", "--module", "SomeApp"] end
        expected_context = [app_name: "some_app", module: "SomeApp"]
        assert_rendered_template("#{template}/mix.exs", "some_app/mix.exs", expected_context)
        assert_rendered_template("#{template}/lib/<%= app_name %>.ex", "some_app/lib/some_app.ex", expected_context)
        assert_rendered_template("#{template}/lib/<%= app_name %>/router.ex", "some_app/lib/some_app/router.ex", expected_context)
      end
    end
  end
end
