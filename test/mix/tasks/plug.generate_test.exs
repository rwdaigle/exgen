defmodule Mix.Tasks.Plug.GenerateTest do

  use ExUnit.Case
  import MixHelper

  setup do
    Mix.Task.clear
    :ok
  end

  test "generates app in current dir" do

    in_tmp "generate-app", fn ->
      Mix.Tasks.Plug.Generate.run ["some_app"]

      assert_file "lib/some_app.ex", fn file ->
        assert file =~ "defmodule SomeApp do"
        assert file =~ "worker(SomeApp.Router, [])"
        assert file =~ "opts = [strategy: :one_for_one, name: SomeApp.Supervisor]"
      end
    end
  end

  test "generates app in relative dir" do

    in_tmp "generate-app", fn ->

      dir = "./test/some_app"
      Mix.Tasks.Plug.Generate.run [dir]

      in_dir dir, fn ->
        assert_file "lib/some_app.ex", fn file ->
          assert file =~ "defmodule SomeApp do"
          assert file =~ "worker(SomeApp.Router, [])"
          assert file =~ "opts = [strategy: :one_for_one, name: SomeApp.Supervisor]"
        end
      end
    end
  end
end
