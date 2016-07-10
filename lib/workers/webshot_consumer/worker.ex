defmodule Workers.WebshotConsumer.Worker do
  @root_folder "./webshots"

  def start_link(action) do
    pid = spawn_link(__MODULE__, :work, [action])
    {:ok, pid}
  end

  def work(action) do
    Process.sleep(100)
    case File.ls(@root_folder) do
      {:ok, [file | t]} ->
        entry = do_work(file)
        action.(file, entry)
      _ -> :noop
    end
    work(action)
  end

  defp do_work(file) do
    path = "#{@root_folder}/#{file}"
    {:ok, entry} = put_in_db(path)
    delete(path)
    entry
  end

  defp delete path do
    File.rm(path)
  end

  defp put_in_db path do
    {:ok, data} = File.read(path)
    Database.Snapshot.changeset(
      %Database.Snapshot{}, %{"name" => "test", "data" => data})
    |> Database.Repo.insert
  end
end
