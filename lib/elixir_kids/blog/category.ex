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
    |> cast(attrs, [:title, :slug, :type])
    |> validate_required([:title, :slug, :type])
    |> Ecto.Changeset.validate_inclusion(:type, @types)
  end
end
