defmodule ElixirKidsWeb.CategoryController do
  use ElixirKidsWeb, :controller

  alias ElixirKids.Blog
  alias ElixirKids.Blog.Category

  def index(conn, _params) do
    categories = Blog.list_categories()
    render(conn, "index.html", categories: categories)
  end

  def new(conn, _params) do
    changeset = Blog.change_category(%Category{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"category" => category_params}) do
    new_slug = Slug.slugify(category_params["title"])
    new_category = Map.put(category_params, "slug", new_slug)
    case Blog.create_category(new_category) do
      {:ok, category} ->
        conn
        |> put_flash(:info, "Category created successfully.")
        |> redirect(to: Routes.category_path(conn, :show, category))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    category = Blog.get_category!(id)
    render(conn, "show.html", category: category)
  end

  def edit(conn, %{"id" => id}) do
    category = Blog.get_category!(id)
    changeset = Blog.change_category(category)
    render(conn, "edit.html", category: category, changeset: changeset)
  end

  def update(conn, %{"id" => id, "category" => category_params}) do
    category = Blog.get_category!(id)
    new_slug = Slug.slugify(category_params["title"])
    new_category = Map.put(category_params, "slug", new_slug)
    case Blog.update_category(category, new_category) do
      {:ok, category} ->
        conn
        |> put_flash(:info, "Category updated successfully.")
        |> redirect(to: Routes.category_path(conn, :show, category))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", category: category, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    category = Blog.get_category!(id)
    {:ok, _category} = Blog.delete_category(category)

    conn
    |> put_flash(:info, "Category deleted successfully.")
    |> redirect(to: Routes.category_path(conn, :index))
  end
end
