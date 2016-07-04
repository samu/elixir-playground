defmodule Server.Endpoint do
  # use Phoenix.Endpoint, otp_app: :elixir_playground
  # plug AppRouter

  def start_link do
    Plug.Adapters.Cowboy.http AppRouter, []
  end
end
