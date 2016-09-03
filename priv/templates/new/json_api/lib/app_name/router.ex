defmodule <%= module %>.Router do

  import Plug.Conn
  use Plug.Router

  plug :match
  plug Plug.Parsers, parsers: [:urlencoded, :json], json_decoder: Poison
  plug :dispatch

  def start_link do
    {:ok, _} = Plug.Adapters.Cowboy.http <%= module %>.Router, []
  end

  def init(options) do
    options
  end

  forward "/api/v1", to: <%= module %>.Routers.Api.V1

  get "/" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(%{"hello": "world"}))
  end

  match _ do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(404, Poison.encode!(%{"error": "URL invalid"}))
  end

end
