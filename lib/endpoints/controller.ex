defmodule Endpoints.Controller do
  use Plug.Router
  import Plug.Conn

  plug Plug.Parsers, parsers: [:urlencoded]

  plug :match
  plug :dispatch

  get "/hello/:id" do
    case Database.Repo.get(Database.Snapshot, id) do
      nil -> send_resp(conn, 404, "entry not found :(")
      snapshot ->
        put_resp_content_type(conn, "image/png")
          |> send_resp(200, snapshot.data)
    end
  end

  post "/snapshot" do
    Webshot.Server.take_snapshot(self, conn.params["name"])
    send_resp(conn, 200, "yep!")
  end

  match _ do
    send_resp(conn, 404, "woops")
  end
end
