defmodule AppRouter do
  use Plug.Router
  import Plug.Conn

  plug :match
  plug :dispatch

  get "/hello/:id" do
    case Upload.Repo.get(Snapshot, id) do
      nil -> send_resp(conn, 404, "entry not found :(")
      snapshot ->
        put_resp_content_type(conn, "image/png")
          |> send_resp(200, snapshot.data)
    end
  end

  match _ do
    send_resp(conn, 404, "woops")
  end
end
