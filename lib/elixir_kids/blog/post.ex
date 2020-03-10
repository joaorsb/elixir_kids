defmodule ElixirKids.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias ElixirKids.Blog.Category
  alias ElixirKids.Blog.Media

  schema "posts" do
    field :address, :string
    field :description, :string
    field :image_name, :string
    field :language, :string
    field :lat, :float
    field :lng, :float
    field :neighborhood, :string
    field :site_url, :string
    field :slug, :string
    field :title, :string
    belongs_to :category, Category
    has_many :media, Media

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :description, :address, :image_name, :lat, :lng, :neighborhood, :site_url, :slug, :language])
    |> validate_required([:title, :description, :address, :image_name, :lat, :lng, :neighborhood, :site_url, :slug, :language])
  end
end
