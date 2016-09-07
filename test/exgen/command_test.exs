defmodule Exgen.ExfileTest do

  use ExUnit.Case, async: true
  alias Exgen.Command

  setup do: :ok

  test "load w/o config" do
    {:ok, command} = Command.load(Path.expand("../fixtures/templates/simple", __DIR__), "../some-app", [app_name: "some_app", module: "SomeApp"])
    assert command.template_path == Path.expand("../fixtures/templates/simple", __DIR__)
    assert command.context == [app_name: "some_app", module: "SomeApp"]
    assert command.target_path == "../some-app"
    assert is_nil(command.module)
  end

  test "load w/ config" do
    {:ok, command} = Command.load(Path.expand("../fixtures/templates/simple_with_config", __DIR__), "../some-app")
    assert command.template_path == Path.expand("../fixtures/templates/simple_with_config", __DIR__)
    assert command.context == [app_name: "some_app", module: "SomeApp"]
    assert command.target_path == "../some-app"
    assert !is_nil(command.module)
  end

  test "CLI options override config" do
    {:ok, command} = Command.load(Path.expand("../fixtures/templates/simple_with_config", __DIR__), "../some-app", [module: "MyApp"])
    assert command.context == [app_name: "some_app", module: "MyApp"]
  end

  test "load w/ bad path" do
    {:err, msg} = Command.load(Path.expand("nothingness", __DIR__), "../some-app")
    assert msg == "Could not find #{Path.expand("nothingness", __DIR__)}"
  end
end
