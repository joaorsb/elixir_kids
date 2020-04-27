defmodule ElixirKids.Blog do
  @moduledoc """
  The Blog context.
  """

  import Ecto.Query, warn: false
  alias ElixirKids.Repo
  alias ElixirKids.Blog.Category
  alias ElixirKids.PubSub

  @doc """
  Returns the list of categories.

  ## Examples

      iex> list_categories()
      [%Category{}, ...]

  """
  def list_categories do
    Repo.all(Category)
  end

  @doc """
  Returns the list of categories title and id.

  ## Examples

      iex> list_categories()
      [%Category{}, ...]

  """
  def list_categories_select do
    Repo.all(from(c in Category, select: {c.title, c.id}))
  end

  @doc """
  Returns the list of categories title and id by type.

  ## Examples

      iex> list_categories_select_by_type()
      [%Category{}, ...]

  """
  def list_categories_select_by_type(type) do
    Repo.all(from(c in Category, select: {c.title, c.id}, where: c.type == ^type))
  end

  @doc """
  Gets a single category.

  Raises `Ecto.NoResultsError` if the Category does not exist.

  ## Examples

      iex> get_category!(123)
      %Category{}

      iex> get_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_category!(id), do: Repo.get!(Category, id)

  @doc """
  Creates a category.

  ## Examples

      iex> create_category(%{field: value})
      {:ok, %Category{}}

      iex> create_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a category.

  ## Examples

      iex> update_category(category, %{field: new_value})
      {:ok, %Category{}}

      iex> update_category(category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_category(%Category{} = category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a category.

  ## Examples

      iex> delete_category(category)
      {:ok, %Category{}}

      iex> delete_category(category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_category(%Category{} = category) do
    Repo.delete(category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking category changes.

  ## Examples

      iex> change_category(category)
      %Ecto.Changeset{source: %Category{}}

  """
  def change_category(%Category{} = category) do
    Category.changeset(category, %{})
  end

  alias ElixirKids.Blog.Post

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    Repo.all from p in Post, preload: [:neighborhood, :category]
  end

  @doc """
  Returns the ordered list of posts.

  ## Examples

      iex> list_posts_by_order(order_by)
      [%Post{}, ...]

  """
  def list_posts_by_order(order_by) do
    Repo.all from p in Post, order_by: ^order_by, preload: [:neighborhood, :category]
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id)

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{source: %Post{}}

  """
  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end

  alias ElixirKids.Blog.Media

  @doc """
  Returns the list of medias.

  ## Examples

      iex> list_medias()
      [%Media{}, ...]

  """
  def list_medias do
    Repo.all(Media)
  end

  @doc """
  Gets a single media.

  Raises `Ecto.NoResultsError` if the Media does not exist.

  ## Examples

      iex> get_media!(123)
      %Media{}

      iex> get_media!(456)
      ** (Ecto.NoResultsError)

  """
  def get_media!(id), do: Repo.get!(Media, id)

  @doc """
  Creates a media.

  ## Examples

      iex> create_media(%{field: value})
      {:ok, %Media{}}

      iex> create_media(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_media(attrs \\ %{}) do
    %Media{}
    |> Media.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a media.

  ## Examples

      iex> update_media(media, %{field: new_value})
      {:ok, %Media{}}

      iex> update_media(media, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_media(%Media{} = media, attrs) do
    media
    |> Media.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a media.

  ## Examples

      iex> delete_media(media)
      {:ok, %Media{}}

      iex> delete_media(media)
      {:error, %Ecto.Changeset{}}

  """
  def delete_media(%Media{} = media) do
    Repo.delete(media)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking media changes.

  ## Examples

      iex> change_media(media)
      %Ecto.Changeset{source: %Media{}}

  """
  def change_media(%Media{} = media) do
    Media.changeset(media, %{})
  end

  alias ElixirKids.Blog.Neighborhood

  @doc """
  Returns the list of neighborhoods.

  ## Examples

      iex> list_neighborhoods()
      [%Neighborhood{}, ...]

  """
  def list_neighborhoods do
    Repo.all(Neighborhood)
  end

  def list_neighborhoods(current_page, per_page) do
    Repo.all(
      from n in Neighborhood,
        order_by: [asc: n.id],
        offset: ^((current_page - 1) * per_page),
        limit: ^per_page
    )
  end

  @doc """
  Gets a single neighborhood.

  Raises `Ecto.NoResultsError` if the Neighborhood does not exist.

  ## Examples

      iex> get_neighborhood!(123)
      %Neighborhood{}

      iex> get_neighborhood!(456)
      ** (Ecto.NoResultsError)

  """
  def get_neighborhood!(id), do: Repo.get!(Neighborhood, id)

  @doc """
  Creates a neighborhood.

  ## Examples

      iex> create_neighborhood(%{field: value})
      {:ok, %Neighborhood{}}

      iex> create_neighborhood(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_neighborhood(attrs \\ %{}) do
    %Neighborhood{}
    |> Neighborhood.changeset(attrs)
    |> Repo.insert()
    |> PubSub.broadcast_neighborhoods(:create)

  end

  @doc """
  Updates a neighborhood.

  ## Examples

      iex> update_neighborhood(neighborhood, %{field: new_value})
      {:ok, %Neighborhood{}}

      iex> update_neighborhood(neighborhood, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_neighborhood(%Neighborhood{} = neighborhood, attrs) do
    neighborhood
    |> Neighborhood.changeset(attrs)
    |> Repo.update()
    |> PubSub.broadcast_neighborhoods(:update)
  end

  @doc """
  Deletes a neighborhood.

  ## Examples

      iex> delete_neighborhood(neighborhood)
      {:ok, %Neighborhood{}}

      iex> delete_neighborhood(neighborhood)
      {:error, %Ecto.Changeset{}}

  """
  def delete_neighborhood(%Neighborhood{} = neighborhood) do
    Repo.delete(neighborhood)
    |> PubSub.broadcast_neighborhoods(:delete)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking neighborhood changes.

  ## Examples

      iex> change_neighborhood(neighborhood)
      %Ecto.Changeset{source: %Neighborhood{}}

  """
  def change_neighborhood(neighborhood, attrs \\ %{}) do
    Neighborhood.changeset(neighborhood, attrs)
  end

  @doc """
  Returns the list of neighborhoods name and id.

  ## Examples

      iex> list_neighborhoods_select()
      [%Neighborhood{}, ...]

  """
  def list_neighborhoods_select do
    Repo.all(from(n in Neighborhood, select: {n.name, n.id}))
  end
end
