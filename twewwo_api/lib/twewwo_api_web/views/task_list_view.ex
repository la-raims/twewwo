defmodule TwewwoApiWeb.TaskListView do
  use TwewwoApiWeb, :view
  alias TwewwoApiWeb.TaskListView

  def render("index.json", %{task_lists: task_lists}) do
    %{data: render_many(task_lists, TaskListView, "task_list.json")}
  end

  def render("show.json", %{task_list: task_list}) do
    %{data: render_one(task_list, TaskListView, "task_list.json")}
  end

  def render("task_list.json", %{task_list: task_list}) do
    %{id: task_list.id, name: task_list.name, order: task_list.order}
  end
end
