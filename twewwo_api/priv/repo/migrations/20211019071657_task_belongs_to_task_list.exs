defmodule TwewwoApi.Repo.Migrations.TaskBelongsToTaskList do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      add :task_list_id, references(:task_list)
    end
  end
end
