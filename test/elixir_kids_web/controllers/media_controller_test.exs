defmodule ElixirKidsWeb.MediaControllerTest do
  use ElixirKidsWeb.ConnCase

  alias ElixirKids.Blog

  @create_attrs %{name: "some name", post_id: 42, type: "some type"}
  @update_attrs %{name: "some updated name", post_id: 43, type: "some updated type"}
  @invalid_attrs %{name: nil, post_id: nil, type: nil}

  def fixture(:media) do
    {:ok, media} = Blog.create_media(@create_attrs)
    media
  end

  describe "index" do
    test "lists all medias", %{conn: conn} do
      conn = get(conn, Routes.media_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Medias"
    end
  end

  describe "new media" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.media_path(conn, :new))
      assert html_response(conn, 200) =~ "New Media"
    end
  end

  describe "create media" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.media_path(conn, :create), media: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.media_path(conn, :show, id)

      conn = get(conn, Routes.media_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Media"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.media_path(conn, :create), media: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Media"
    end
  end

  describe "edit media" do
    setup [:create_media]

    test "renders form for editing chosen media", %{conn: conn, media: media} do
      conn = get(conn, Routes.media_path(conn, :edit, media))
      assert html_response(conn, 200) =~ "Edit Media"
    end
  end

  describe "update media" do
    setup [:create_media]

    test "redirects when data is valid", %{conn: conn, media: media} do
      conn = put(conn, Routes.media_path(conn, :update, media), media: @update_attrs)
      assert redirected_to(conn) == Routes.media_path(conn, :show, media)

      conn = get(conn, Routes.media_path(conn, :show, media))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, media: media} do
      conn = put(conn, Routes.media_path(conn, :update, media), media: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Media"
    end
  end

  describe "delete media" do
    setup [:create_media]

    test "deletes chosen media", %{conn: conn, media: media} do
      conn = delete(conn, Routes.media_path(conn, :delete, media))
      assert redirected_to(conn) == Routes.media_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.media_path(conn, :show, media))
      end
    end
  end

  defp create_media(_) do
    media = fixture(:media)
    {:ok, media: media}
  end
end
