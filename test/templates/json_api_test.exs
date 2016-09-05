defmodule Templates.JsonApiTest do

  use ExUnit.Case, async: true
  import MixHelper
  import ExUnit.CaptureIO
  import Mix.PlugTasks
  use Plug.Test

  setup do
    Mix.Task.clear
    :ok
  end

  describe "generated default app paths: " do

    setup do
      app_num = :rand.uniform(10000)
      app_name = "app#{app_num}"

      # Generate and load Plug app
      in_tmp fn ->
        capture_io fn -> Mix.Tasks.Plug.New.run [app_name, "-t", "json_api"] end
        ls_r(app_name) |> Kernel.ParallelCompiler.files
      end

      {router, _} = Code.eval_string("App#{app_num}.Router")
      {:ok, %{router: router}}
    end

    test "/", %{router: router} do
      conn = conn(:get, "/") |> router.call(nil)
      assert conn.state == :sent
      assert conn.status == 200
      assert conn.resp_body == "{\"hello\":\"world\"}"
      assert conn |> get_resp_header("content-type") == ["application/json; charset=utf-8"]
    end

    test "/notfound", %{router: router} do
      conn = conn(:get, "/notfound") |> router.call(nil)
      assert conn.state == :sent
      assert conn.status == 404
      assert conn.resp_body == "{\"error\":\"URL invalid\"}"
      assert conn |> get_resp_header("content-type") == ["application/json; charset=utf-8"]
    end

    test "/api/v1/status", %{router: router} do
      conn = conn(:get, "/api/v1/status") |> router.call(nil)
      assert conn.state == :sent
      assert conn.status == 200
      assert conn.resp_body == "{\"status\":\"ok\"}"
      assert conn |> get_resp_header("content-type") == ["application/json; charset=utf-8"]
    end
  end
end
