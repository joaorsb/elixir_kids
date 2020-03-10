defmodule ElixirKidsWeb.MediaController do
  use ElixirKidsWeb, :controller

  alias ElixirKids.Blog
  alias ElixirKids.Blog.Media

  def index(conn, _params) do
    medias = Blog.list_medias()
    render(conn, "index.html", medias: medias)
  end

  def new(conn, _params) do
    changeset = Blog.change_media(%Media{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"media" => media_params}) do
    case Blog.create_media(media_params) do
      {:ok, media} ->
        conn
        |> put_flash(:info, "Media created successfully.")
        |> redirect(to: Routes.media_path(conn, :show, media))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    media = Blog.get_media!(id)
    render(conn, "show.html", media: media)
  end

  def edit(conn, %{"id" => id}) do
    media = Blog.get_media!(id)
    changeset = Blog.change_media(media)
    render(conn, "edit.html", media: media, changeset: changeset)
  end

  def update(conn, %{"id" => id, "media" => media_params}) do
    media = Blog.get_media!(id)

    case Blog.update_media(media, media_params) do
      {:ok, media} ->
        conn
        |> put_flash(:info, "Media updated successfully.")
        |> redirect(to: Routes.media_path(conn, :show, media))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", media: media, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    media = Blog.get_media!(id)
    {:ok, _media} = Blog.delete_media(media)

    conn
    |> put_flash(:info, "Media deleted successfully.")
    |> redirect(to: Routes.media_path(conn, :index))
  end
end
