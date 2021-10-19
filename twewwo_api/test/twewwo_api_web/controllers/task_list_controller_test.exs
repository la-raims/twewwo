defmodule TwewwoApiWeb.TaskListControllerTest do
  use TwewwoApiWeb.ConnCase

  alias TwewwoApi.Todo
  alias TwewwoApi.Todo.TaskList

  @create_attrs %{
    name: "some name",
    order: []
  }
  @update_attrs %{
    name: "some updated name",
    order: []
  }
  @invalid_attrs %{name: nil, order: nil}

  def fixture(:task_list) do
    {:ok, task_list} = Todo.create_task_list(@create_attrs)
    task_list
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all task_lists", %{conn: conn} do
      conn = get(conn, Routes.task_list_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create task_list" do
    test "renders task_list when data is valid", %{conn: conn} do
      conn = post(conn, Routes.task_list_path(conn, :create), task_list: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.task_list_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some name",
               "order" => []
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.task_list_path(conn, :create), task_list: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update task_list" do
    setup [:create_task_list]

    test "renders task_list when data is valid", %{conn: conn, task_list: %TaskList{id: id} = task_list} do
      conn = put(conn, Routes.task_list_path(conn, :update, task_list), task_list: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.task_list_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some updated name",
               "order" => []
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, task_list: task_list} do
      conn = put(conn, Routes.task_list_path(conn, :update, task_list), task_list: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete task_list" do
    setup [:create_task_list]

    test "deletes chosen task_list", %{conn: conn, task_list: task_list} do
      conn = delete(conn, Routes.task_list_path(conn, :delete, task_list))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.task_list_path(conn, :show, task_list))
      end
    end
  end

  defp create_task_list(_) do
    task_list = fixture(:task_list)
    %{task_list: task_list}
  end
end
