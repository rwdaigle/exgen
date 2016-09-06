defmodule Mix.ExgenTest do

  use ExUnit.Case, async: true
  import Mix.Exgen

  setup do: :ok

  test "ls_r recursively lists regular files" do
    list = ls_r Path.expand("../fixtures/ls_r", __DIR__)
    assert Enum.count(list) == 3
    assert list |> Enum.member?(Path.expand("../fixtures/ls_r/hi.ex", __DIR__))
    assert list |> Enum.member?(Path.expand("../fixtures/ls_r/subdir/file.txt", __DIR__))
    assert list |> Enum.member?(Path.expand("../fixtures/ls_r/subdir/subsubdir/nother.rb", __DIR__))
  end
end
