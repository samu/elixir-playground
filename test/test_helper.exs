# import Supervisor.Spec
# children = [supervisor(Upload.Repo, [])]
# Supervisor.start_link(children, strategy: :one_for_one)
#
ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(Upload.Repo, :manual)
