defmodule Upload.Repo.Migrations.AddSnapshotsTable do
  use Ecto.Migration

  def change do
    create table(:snapshots) do
      add :name, :string
      add :data, :binary
      timestamps
    end
  end
end
