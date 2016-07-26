defmodule Mix.Tasks.Plug.Generate do

  use ExUnit.Case
  import MixHelper

  setup do
    Mix.Task.clear
    :ok
  end

  test "generates app" do

    in_tmp "generates app", fn ->
      Mix.Tasks.Plug.Generate.run ["some_app"]

      assert_file "lib/some_app.ex", fn file ->
        assert file =~ "defmodule SomeApp do"
        assert file =~ "worker(SomeApp.Router, [])"
        assert file =~ "opts = [strategy: :one_for_one, name: SomeApp.Supervisor]"
      end
    end
  end
end
