defmodule <%= module %>.Routers.Api.V1 do

  import Plug.Conn
  use Plug.Router

  plug :match
  plug Plug.Parsers, parsers: [:urlencoded, :json], json_decoder: Poison
  plug :dispatch

  get "/status" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(%{"status": "ok"}))
  end
end
