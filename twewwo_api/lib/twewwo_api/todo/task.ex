defmodule TwewwoApi.Todo.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :description, :string
    field :title, :string
    belongs_to :task_lists, TwewwoApi.TaskList

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
