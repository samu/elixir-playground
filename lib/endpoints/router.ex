defmodule Endpoints.Router do
  use Plug.Builder

  plug Plug.Static,
    at: "/public",
    from: "/Users/samuelmueller/Development/vue-playground"

  plug Plug.Static,
    at: "/frontend",
    from: "frontend"

  plug Endpoints.Controller
end
