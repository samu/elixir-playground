defmodule Web.Controller do
  use Phoenix.Controller

  alias Database.Repo
  import Ecto
  import Ecto.Query

  # import Snippster.Gettext

  def index(conn, _params) do
    # render conn, "index.html"
    send_resp(conn, 404, "woops")
  end

  def snapshot(conn, params) do
    Webshot.Server.take_snapshot(self, params["name"])
    send_resp(conn, 200, "yep!")
  end
end
