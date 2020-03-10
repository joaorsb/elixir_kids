defmodule ElixirKids.BlogTest do
  use ElixirKids.DataCase

  alias ElixirKids.Blog

  describe "categories" do
    alias ElixirKids.Blog.Category

    @valid_attrs %{slug: "some slug", title: "some title", type: "some type"}
    @update_attrs %{slug: "some updated slug", title: "some updated title", type: "some updated type"}
    @invalid_attrs %{slug: nil, title: nil, type: nil}

    def category_fixture(attrs \\ %{}) do
      {:ok, category} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blog.create_category()

      category
    end

    test "list_categories/0 returns all categories" do
      category = category_fixture()
      assert Blog.list_categories() == [category]
    end

    test "get_category!/1 returns the category with given id" do
      category = category_fixture()
      assert Blog.get_category!(category.id) == category
    end

    test "create_category/1 with valid data creates a category" do
      assert {:ok, %Category{} = category} = Blog.create_category(@valid_attrs)
      assert category.slug == "some slug"
      assert category.title == "some title"
      assert category.type == "some type"
    end

    test "create_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_category(@invalid_attrs)
    end

    test "update_category/2 with valid data updates the category" do
      category = category_fixture()
      assert {:ok, %Category{} = category} = Blog.update_category(category, @update_attrs)
      assert category.slug == "some updated slug"
      assert category.title == "some updated title"
      assert category.type == "some updated type"
    end

    test "update_category/2 with invalid data returns error changeset" do
      category = category_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_category(category, @invalid_attrs)
      assert category == Blog.get_category!(category.id)
    end

    test "delete_category/1 deletes the category" do
      category = category_fixture()
      assert {:ok, %Category{}} = Blog.delete_category(category)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_category!(category.id) end
    end

    test "change_category/1 returns a category changeset" do
      category = category_fixture()
      assert %Ecto.Changeset{} = Blog.change_category(category)
    end
  end

  describe "posts" do
    alias ElixirKids.Blog.Post

    @valid_attrs %{address: "some address", description: "some description", image_name: "some image_name", language: "some language", lat: 120.5, lng: 120.5, neighborhood: "some neighborhood", site_url: "some site_url", slug: "some slug", title: "some title"}
    @update_attrs %{address: "some updated address", description: "some updated description", image_name: "some updated image_name", language: "some updated language", lat: 456.7, lng: 456.7, neighborhood: "some updated neighborhood", site_url: "some updated site_url", slug: "some updated slug", title: "some updated title"}
    @invalid_attrs %{address: nil, description: nil, image_name: nil, language: nil, lat: nil, lng: nil, neighborhood: nil, site_url: nil, slug: nil, title: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blog.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Blog.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Blog.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Blog.create_post(@valid_attrs)
      assert post.address == "some address"
      assert post.description == "some description"
      assert post.image_name == "some image_name"
      assert post.language == "some language"
      assert post.lat == 120.5
      assert post.lng == 120.5
      assert post.neighborhood == "some neighborhood"
      assert post.site_url == "some site_url"
      assert post.slug == "some slug"
      assert post.title == "some title"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = Blog.update_post(post, @update_attrs)
      assert post.address == "some updated address"
      assert post.description == "some updated description"
      assert post.image_name == "some updated image_name"
      assert post.language == "some updated language"
      assert post.lat == 456.7
      assert post.lng == 456.7
      assert post.neighborhood == "some updated neighborhood"
      assert post.site_url == "some updated site_url"
      assert post.slug == "some updated slug"
      assert post.title == "some updated title"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_post(post, @invalid_attrs)
      assert post == Blog.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Blog.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Blog.change_post(post)
    end
  end

  describe "medias" do
    alias ElixirKids.Blog.Media

    @valid_attrs %{name: "some name", post_id: 42, type: "some type"}
    @update_attrs %{name: "some updated name", post_id: 43, type: "some updated type"}
    @invalid_attrs %{name: nil, post_id: nil, type: nil}

    def media_fixture(attrs \\ %{}) do
      {:ok, media} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blog.create_media()

      media
    end

    test "list_medias/0 returns all medias" do
      media = media_fixture()
      assert Blog.list_medias() == [media]
    end

    test "get_media!/1 returns the media with given id" do
      media = media_fixture()
      assert Blog.get_media!(media.id) == media
    end

    test "create_media/1 with valid data creates a media" do
      assert {:ok, %Media{} = media} = Blog.create_media(@valid_attrs)
      assert media.name == "some name"
      assert media.post_id == 42
      assert media.type == "some type"
    end

    test "create_media/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_media(@invalid_attrs)
    end

    test "update_media/2 with valid data updates the media" do
      media = media_fixture()
      assert {:ok, %Media{} = media} = Blog.update_media(media, @update_attrs)
      assert media.name == "some updated name"
      assert media.post_id == 43
      assert media.type == "some updated type"
    end

    test "update_media/2 with invalid data returns error changeset" do
      media = media_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_media(media, @invalid_attrs)
      assert media == Blog.get_media!(media.id)
    end

    test "delete_media/1 deletes the media" do
      media = media_fixture()
      assert {:ok, %Media{}} = Blog.delete_media(media)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_media!(media.id) end
    end

    test "change_media/1 returns a media changeset" do
      media = media_fixture()
      assert %Ecto.Changeset{} = Blog.change_media(media)
    end
  end
end
