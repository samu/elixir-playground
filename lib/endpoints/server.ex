defmodule Endpoints.Server do
  def start_link do
    Plug.Adapters.Cowboy.http Endpoints.Router, []
  end
end
