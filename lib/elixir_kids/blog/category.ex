defmodule ElixirKids.Blog.Category do
  use Ecto.Schema
  import Ecto.Changeset
  alias ElixirKids.Blog.Post

  @types ~w(Free Paid)

  schema "categories" do
    field :slug, :string
    field :title, :string
    field :type, :string
    has_many :posts, Post

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:title, :type])
    |> validate_required([:title, :type])
    |> Ecto.Changeset.validate_inclusion(:type, @types)
    |> create_slug
  end

  defp create_slug(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{title: title}} ->
        put_change(changeset, :slug, Slug.slugify(title))
      _ ->
        changeset
    end
  end
end
