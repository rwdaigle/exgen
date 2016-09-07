defmodule Mix.ExgenTest do

  use ExUnit.Case, async: true
  import Mix.Exgen

  setup do: :ok

  test "ls_r recursively lists regular files from an absolute dir" do
    list = ls_r Path.expand("../fixtures/ls_r", __DIR__)
    assert Enum.count(list) == 3
    assert list |> Enum.member?(Path.expand("../fixtures/ls_r/hi.ex", __DIR__))
    assert list |> Enum.member?(Path.expand("../fixtures/ls_r/subdir/file.txt", __DIR__))
    assert list |> Enum.member?(Path.expand("../fixtures/ls_r/subdir/subsubdir/nother.rb", __DIR__))
  end

  test "ls_r recursively lists regular files from a relative dir" do
    list = ls_r "test/fixtures/ls_r"
    assert Enum.count(list) == 3
    assert list |> Enum.member?("test/fixtures/ls_r/hi.ex")
    assert list |> Enum.member?("test/fixtures/ls_r/subdir/file.txt")
    assert list |> Enum.member?("test/fixtures/ls_r/subdir/subsubdir/nother.rb")
  end
end
