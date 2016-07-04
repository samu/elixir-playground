defmodule Server.Endpoint do
  def start_link do
    Plug.Adapters.Cowboy.http AppRouter, []
  end
end
