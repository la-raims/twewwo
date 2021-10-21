defmodule TwewwoApiWeb.TaskControllerTest do
  use TwewwoApiWeb.ConnCase

  alias TwewwoApi.Todo
  alias TwewwoApi.Todo.Task

  @create_attrs %{
    description: "some description",
    title: "some title"
  }
  @update_attrs %{
    description: "some updated description",
    title: "some updated title"
  }
  @invalid_attrs %{description: nil, title: nil}

  def task_list_fixture(attrs \\ %{}) do
    {:ok, task_list} =
      attrs
      |> Enum.into(%{name: "some name", order: []})
      |> Todo.create_task_list()

    task_list
  end

  def fixture(attrs \\ %{}) do
    {:ok, %{task: task}} =
      attrs
      |> Enum.into(@create_attrs)
      |> Todo.create_task()

    task
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    setup [:create_task_list]

    test "lists all tasks", %{conn: conn, task_list: task_list} do
      conn = get(conn, Routes.task_list_task_path(conn, :index, task_list.id))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create task" do
    setup [:create_task_list]

    test "renders task when data is valid", %{conn: conn, task_list: task_list} do
      conn =
        post(conn, Routes.task_list_task_path(conn, :create, task_list.id),
          task: Map.put(@create_attrs, :task_list_id, task_list.id)
        )

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.task_list_task_path(conn, :show, task_list.id, id))

      assert %{
               "id" => id,
               "description" => "some description",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, task_list: task_list} do
      conn =
        post(conn, Routes.task_list_task_path(conn, :create, task_list.id),
          task: Map.put(@invalid_attrs, :task_list_id, task_list.id)
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update task" do
    setup [:create_task]

    test "renders task when data is valid", %{
      conn: conn,
      task: %Task{id: id, task_list_id: task_list_id} = task
    } do
      conn =
        put(conn, Routes.task_list_task_path(conn, :update, task_list_id, task),
          task: @update_attrs
        )

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.task_list_task_path(conn, :show, task_list_id, id))

      assert %{
               "id" => id,
               "description" => "some updated description",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{
      conn: conn,
      task: %Task{task_list_id: task_list_id} = task
    } do
      conn =
        put(conn, Routes.task_list_task_path(conn, :update, task_list_id, task),
          task: @invalid_attrs
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete task" do
    setup [:create_task]

    test "deletes chosen task", %{conn: conn, task: %Task{task_list_id: task_list_id} = task} do
      conn = delete(conn, Routes.task_list_task_path(conn, :delete, task_list_id, task))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.task_list_task_path(conn, :show, task_list_id, task))
      end
    end
  end

  defp create_task_list(_) do
    task_list = task_list_fixture()
    %{task_list: task_list}
  end

  defp create_task(_) do
    task_list = task_list_fixture()
    task = fixture(%{task_list_id: task_list.id})
    %{task: task}
  end
end
