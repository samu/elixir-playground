defmodule AppRouter do
  use Plug.Builder

  plug Plug.Static,
    at: "/public",
    from: "/Users/samuelmueller/Development/vue-playground"

  plug Plug.Static,
    at: "/frontend",
    from: "frontend"

  plug Controller
end
