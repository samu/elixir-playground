defmodule Upload.RepoTest do
  use ExUnit.Case

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Upload.Repo)
    
    Ecto.Adapters.SQL.Sandbox.mode(Upload.Repo, {:shared, self()})

    :ok
  end

  test "stuff" do

  end
end
