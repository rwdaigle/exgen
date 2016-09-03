defmodule Mix.Tasks.Plug.NewTest do

  use ExUnit.Case
  import MixHelper

  setup do
    Mix.Task.clear
    :ok
  end

  test "generates app in current dir" do

    in_tmp "new-app", fn ->

      app_name = "some_app"
      Mix.Tasks.Plug.New.run [app_name]

      in_dir app_name, fn ->
        assert_file "lib/some_app.ex", fn file ->
          assert file =~ "defmodule SomeApp do"
          assert file =~ "worker(SomeApp.Router, [])"
          assert file =~ "opts = [strategy: :one_for_one, name: SomeApp.Supervisor]"
        end
      end
    end
  end

  test "generates app in relative dir" do

    in_tmp "new-app", fn ->

      dir = "./test/some_app"
      Mix.Tasks.Plug.New.run [dir]

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
