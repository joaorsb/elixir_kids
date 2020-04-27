defmodule ElixirKidsWeb.NeighborhoodController do
  use ElixirKidsWeb, :controller

  alias ElixirKids.Blog
  alias ElixirKids.Blog.Neighborhood
  alias ElixirKids.PubSub

  def index(conn, _params) do
    neighborhoods = Blog.list_neighborhoods()
    render(conn, "index.html", neighborhoods: neighborhoods)
  end

  def new(conn, _params) do
    changeset = Blog.change_neighborhood(%Neighborhood{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"neighborhood" => neighborhood_params}) do

    case Blog.create_neighborhood(neighborhood_params) do
      {:ok, neighborhood} ->
        conn
        |> put_flash(:info, "Neighborhood created successfully.")
        |> redirect(to: Routes.neighborhood_path(conn, :show, neighborhood))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    neighborhood = Blog.get_neighborhood!(id)
    render(conn, "show.html", neighborhood: neighborhood)
  end

  def edit(conn, %{"id" => id}) do
    neighborhood = Blog.get_neighborhood!(id)
    changeset = Blog.change_neighborhood(neighborhood)
    render(conn, "edit.html", neighborhood: neighborhood, changeset: changeset)
  end

  def update(conn, %{"id" => id, "neighborhood" => neighborhood_params}) do
    neighborhood = Blog.get_neighborhood!(id)

    case Blog.update_neighborhood(neighborhood, neighborhood_params) do
      {:ok, neighborhood} ->
        conn
        |> put_flash(:info, "Neighborhood updated successfully.")
        |> redirect(to: Routes.neighborhood_path(conn, :show, neighborhood))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", neighborhood: neighborhood, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    neighborhood = Blog.get_neighborhood!(id)
    {:ok, _neighborhood} = Blog.delete_neighborhood(neighborhood)

    conn
    |> put_flash(:info, "Neighborhood deleted successfully.")
    |> redirect(to: Routes.neighborhood_path(conn, :index))
  end
end
