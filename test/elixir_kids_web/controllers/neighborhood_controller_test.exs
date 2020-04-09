defmodule ElixirKidsWeb.NeighborhoodControllerTest do
  use ElixirKidsWeb.ConnCase

  alias ElixirKids.Blog

  @create_attrs %{latitude: 120.5, longitude: 120.5, name: "some name"}
  @update_attrs %{latitude: 456.7, longitude: 456.7, name: "some updated name"}
  @invalid_attrs %{latitude: nil, longitude: nil, name: nil}

  def fixture(:neighborhood) do
    {:ok, neighborhood} = Blog.create_neighborhood(@create_attrs)
    neighborhood
  end

  describe "index" do
    test "lists all neighborhoods", %{conn: conn} do
      conn = get(conn, Routes.neighborhood_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Neighborhoods"
    end
  end

  describe "new neighborhood" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.neighborhood_path(conn, :new))
      assert html_response(conn, 200) =~ "New Neighborhood"
    end
  end

  describe "create neighborhood" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.neighborhood_path(conn, :create), neighborhood: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.neighborhood_path(conn, :show, id)

      conn = get(conn, Routes.neighborhood_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Neighborhood"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.neighborhood_path(conn, :create), neighborhood: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Neighborhood"
    end
  end

  describe "edit neighborhood" do
    setup [:create_neighborhood]

    test "renders form for editing chosen neighborhood", %{conn: conn, neighborhood: neighborhood} do
      conn = get(conn, Routes.neighborhood_path(conn, :edit, neighborhood))
      assert html_response(conn, 200) =~ "Edit Neighborhood"
    end
  end

  describe "update neighborhood" do
    setup [:create_neighborhood]

    test "redirects when data is valid", %{conn: conn, neighborhood: neighborhood} do
      conn = put(conn, Routes.neighborhood_path(conn, :update, neighborhood), neighborhood: @update_attrs)
      assert redirected_to(conn) == Routes.neighborhood_path(conn, :show, neighborhood)

      conn = get(conn, Routes.neighborhood_path(conn, :show, neighborhood))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, neighborhood: neighborhood} do
      conn = put(conn, Routes.neighborhood_path(conn, :update, neighborhood), neighborhood: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Neighborhood"
    end
  end

  describe "delete neighborhood" do
    setup [:create_neighborhood]

    test "deletes chosen neighborhood", %{conn: conn, neighborhood: neighborhood} do
      conn = delete(conn, Routes.neighborhood_path(conn, :delete, neighborhood))
      assert redirected_to(conn) == Routes.neighborhood_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.neighborhood_path(conn, :show, neighborhood))
      end
    end
  end

  defp create_neighborhood(_) do
    neighborhood = fixture(:neighborhood)
    {:ok, neighborhood: neighborhood}
  end
end
