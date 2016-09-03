defmodule <%= module %>.Router do

  import Plug.Conn
  use Plug.Router

  plug :match
  plug :dispatch

  def start_link do
    {:ok, _} = Plug.Adapters.Cowboy.http <%= module %>.Router, []
  end

  def init(options) do
    options
  end

  # forward "/api", to: <%= module %>.Routers.Api

  get "/" do
    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, "Hello there!")
  end

  match _ do
    send_resp(conn, 404, "Unknown request")
  end

end
