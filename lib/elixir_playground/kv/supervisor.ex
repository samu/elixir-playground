defmodule ElixirPlayground.KV.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    children = [
      worker(ElixirPlayground.KV.Registry, [ElixirPlayground.KV.Registry]),
      supervisor(ElixirPlayground.KV.Bucket.Supervisor, [])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
