defmodule TwewwoApi.Todo.TaskList do
  use Ecto.Schema
  import Ecto.Changeset

  schema "task_lists" do
    field :name, :string
    field :order, {:array, :id}

    timestamps()
  end

  @doc false
  def changeset(task_list, attrs) do
    task_list
    |> cast(attrs, [:name, :order])
    |> validate_required([:name, :order])
  end
end
