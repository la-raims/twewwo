defmodule TwewwoApiWeb.TaskListController do
  use TwewwoApiWeb, :controller

  alias TwewwoApi.Todo
  alias TwewwoApi.Todo.TaskList

  action_fallback TwewwoApiWeb.FallbackController

  def index(conn, _params) do
    task_lists = Todo.list_task_lists()
    render(conn, "index.json", task_lists: task_lists)
  end

  def create(conn, %{"task_list" => task_list_params}) do
    with {:ok, %TaskList{} = task_list} <- Todo.create_task_list(task_list_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.task_list_path(conn, :show, task_list))
      |> render("show.json", task_list: task_list)
    end
  end

  def show(conn, %{"id" => id}) do
    task_list = Todo.get_task_list!(id)
    render(conn, "show.json", task_list: task_list)
  end

  def update(conn, %{"id" => id, "task_list" => task_list_params}) do
    task_list = Todo.get_task_list!(id)

    with {:ok, %TaskList{} = task_list} <- Todo.update_task_list(task_list, task_list_params) do
      render(conn, "show.json", task_list: task_list)
    end
  end

  def delete(conn, %{"id" => id}) do
    task_list = Todo.get_task_list!(id)

    with {:ok, %TaskList{}} <- Todo.delete_task_list(task_list) do
      send_resp(conn, :no_content, "")
    end
  end
end
