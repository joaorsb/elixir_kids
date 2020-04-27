defmodule ElixirKidsWeb.PostController do
  use ElixirKidsWeb, :controller

  alias ElixirKids.Blog
  alias ElixirKids.Blog.Post
  alias ElixirKids.PubSub

  plug :load_categories when action in [:new, :create, :edit, :update]
  plug :load_neighborhoods when action in [:new, :create, :edit, :update]
  plug :load_languages when action in [:new, :create, :edit, :update]

  def index(conn, _params) do
    posts = Blog.list_posts()
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = Blog.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    case Blog.create_post(post_params) do
      {:ok, post} ->
        PubSub.broadcast_post(:create, post)
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    render(conn, "show.html", post: post)
  end

  def edit(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    changeset = Blog.change_post(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Blog.get_post!(id)
    case Blog.update_post(post, post_params) do
      {:ok, post} ->
        PubSub.broadcast_post(:update, post)
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Blog.get_post!(id)
    {:ok, _post} = Blog.delete_post(post)
    PubSub.broadcast_post(:delete, post)
    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: Routes.post_path(conn, :index))
  end

  defp load_categories(conn, _) do
    categories = Blog.list_categories_select()
    assign(conn, :categories, categories)
  end

  defp load_neighborhoods(conn, _) do
    neighborhoods = Blog.list_neighborhoods_select()
    assign(conn, :neighborhoods, neighborhoods)
  end

  defp load_languages(conn, _) do
    languages = %{"Norsk" => "no", "English" => "en"}
    assign(conn, :languages, languages)
  end
end
