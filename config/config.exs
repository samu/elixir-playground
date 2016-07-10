# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :elixir_playground, ecto_repos: [Database.Repo]

config :elixir_playground, Database.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "upload",
  username: "postgres",
  password: "postgres",
  pool: Ecto.Adapters.SQL.Sandbox

config :elixir_playground, Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Cl1ksnpon4se/NCiaDneGt5Z7SsYS52Mfu/z/b012wtD7/vMyRxcWmBeV/X63RhE",
  # render_errors: [view: Snippster.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Web.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

import_config "#{Mix.env}.exs"
