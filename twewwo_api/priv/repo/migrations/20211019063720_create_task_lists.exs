defmodule TwewwoApi.Repo.Migrations.CreateTaskLists do
  use Ecto.Migration

  def change do
    create table(:task_lists) do
      add :name, :string
      add :order, {:array, :id}

      timestamps()
    end
  end
end
