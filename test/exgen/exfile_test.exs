defmodule Exgen.ExfileTest do

  use ExUnit.Case, async: true
  alias Exgen.Exfile

  setup do: :ok

  test "exfile" do
    {:ok, exfile} = Exfile.exfile(Path.expand("../fixtures/templates/simple", __DIR__), "../some-app")
    assert exfile.template_path == Path.expand("../fixtures/templates/simple", __DIR__)
    assert exfile.context == [app_name: "some_app", module: "SomeApp"]
    assert exfile.target_path == "../some-app"
    assert !is_nil(exfile.module)

    {:error, msg} = Exfile.exfile(Path.expand("../nothingness", __DIR__), "../some-app")
    assert msg == "Could not find #{Path.expand("../nothingness", __DIR__)}"
  end

  test "target_file_name" do
    {:ok, exfile} = Exfile.exfile("test/fixtures/templates/simple", "../some-app")
    assert "../some-app/lib/some_app.ex" == exfile |> Exfile.target_file("test/fixtures/templates/simple/lib/app_name.ex")
    assert "../some-app/appname.ex" == exfile |> Exfile.target_file("test/fixtures/templates/simple/appname.ex")
    assert "../some-app/test/some_app_test.exs" == exfile |> Exfile.target_file("test/fixtures/templates/simple/test/app_name_test.exs")
  end
end
