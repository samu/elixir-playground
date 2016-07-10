defmodule ElixirPlayground do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Endpoints.Server, []),
      supervisor(Database.Repo, []),
      supervisor(Webshot.Supervisor, []),
      supervisor(Workers.WebshotConsumer.Supervisor, [Hub.Server.produce_webshot_consumer_action]),
      supervisor(Hub.Supervisor, [])
    ]

    opts = [strategy: :one_for_one, name: ElixirPlayground.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
