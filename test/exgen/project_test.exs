defmodule Exgen.ProjectTest do

  use ExUnit.Case, async: true
  alias Exgen.Project

  setup do: :ok

  test "target_base" do
    base = %Project{target: "../../test/some_dir"} |> Project.target_base
    assert base == "some_dir"

    base = %Project{target: "../../test/some-dir"} |> Project.target_base
    assert base == "some_dir"
  end

  test "module_name" do
    module_name = %Project{target: "../../test/some_dir"} |> Project.module_name
    assert module_name == "SomeDir"

    module_name = %Project{target: "../../test/some-dir"} |> Project.module_name
    assert module_name == "SomeDir"
  end
end
