defmodule AppRouter do
  use Plug.Builder
  import Plug.Conn

  plug Plug.Static,
    at: "/public",
    from: "/Users/samuelmueller/Development/vue-playground"

  plug LePlug
end
