# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :elixir_playground, ecto_repos: [Upload.Repo]

config :elixir_playground, Upload.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "upload",
  username: "postgres",
  password: "postgres",
  pool: Ecto.Adapters.SQL.Sandbox
