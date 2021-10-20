defmodule TwewwoApi.Todo.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :description, :string
    field :title, :string
    belongs_to :task_list, TwewwoApi.Todo.TaskList

    timestamps()
  end

  @required_attrs [
    :title,
    :description,
    :task_list_id
  ]

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, @required_attrs)
    |> foreign_key_constraint(:task_list_id)
    |> validate_required(@required_attrs)
  end
end
