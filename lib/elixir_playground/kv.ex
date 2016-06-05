defmodule ElixirPlayground.KV do
  use Application

  def start(_type, _args) do
    ElixirPlayground.KV.Supervisor.start_link
  end
end
