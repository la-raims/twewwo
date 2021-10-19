defmodule TwewwoApi.TodoTest do
  use TwewwoApi.DataCase

  alias TwewwoApi.Todo

  describe "task_lists" do
    alias TwewwoApi.Todo.TaskList

    @valid_attrs %{name: "some name", order: []}
    @update_attrs %{name: "some updated name", order: []}
    @invalid_attrs %{name: nil, order: nil}

    def task_list_fixture(attrs \\ %{}) do
      {:ok, task_list} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Todo.create_task_list()

      task_list
    end

    test "list_task_lists/0 returns all task_lists" do
      task_list = task_list_fixture()
      assert Todo.list_task_lists() == [task_list]
    end

    test "get_task_list!/1 returns the task_list with given id" do
      task_list = task_list_fixture()
      assert Todo.get_task_list!(task_list.id) == task_list
    end

    test "create_task_list/1 with valid data creates a task_list" do
      assert {:ok, %TaskList{} = task_list} = Todo.create_task_list(@valid_attrs)
      assert task_list.name == "some name"
      assert task_list.order == []
    end

    test "create_task_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todo.create_task_list(@invalid_attrs)
    end

    test "update_task_list/2 with valid data updates the task_list" do
      task_list = task_list_fixture()
      assert {:ok, %TaskList{} = task_list} = Todo.update_task_list(task_list, @update_attrs)
      assert task_list.name == "some updated name"
      assert task_list.order == []
    end

    test "update_task_list/2 with invalid data returns error changeset" do
      task_list = task_list_fixture()
      assert {:error, %Ecto.Changeset{}} = Todo.update_task_list(task_list, @invalid_attrs)
      assert task_list == Todo.get_task_list!(task_list.id)
    end

    test "delete_task_list/1 deletes the task_list" do
      task_list = task_list_fixture()
      assert {:ok, %TaskList{}} = Todo.delete_task_list(task_list)
      assert_raise Ecto.NoResultsError, fn -> Todo.get_task_list!(task_list.id) end
    end

    test "change_task_list/1 returns a task_list changeset" do
      task_list = task_list_fixture()
      assert %Ecto.Changeset{} = Todo.change_task_list(task_list)
    end
  end

  describe "tasks" do
    alias TwewwoApi.Todo.Task

    @valid_attrs %{description: "some description", title: "some title"}
    @update_attrs %{description: "some updated description", title: "some updated title"}
    @invalid_attrs %{description: nil, title: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Todo.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Todo.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Todo.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Todo.create_task(@valid_attrs)
      assert task.description == "some description"
      assert task.title == "some title"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Todo.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, %Task{} = task} = Todo.update_task(task, @update_attrs)
      assert task.description == "some updated description"
      assert task.title == "some updated title"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Todo.update_task(task, @invalid_attrs)
      assert task == Todo.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Todo.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Todo.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Todo.change_task(task)
    end
  end
end
