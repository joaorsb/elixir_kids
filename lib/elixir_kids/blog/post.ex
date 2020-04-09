defmodule ElixirKids.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias ElixirKids.Blog.{ Category, Media, Neighborhood }
  alias GoogleMaps, as: Maps

  schema "posts" do
    field :address, :string
    field :description, :string
    field :image_name, :string
    field :language, :string
    field :lat, :float
    field :lng, :float
    field :site_url, :string
    field :slug, :string
    field :title, :string
    belongs_to :category, Category
    belongs_to :neighborhood, Neighborhood
    has_many :media, Media

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :description, :address, :language, :neighborhood_id, :category_id])
    |> validate_required([:title, :description, :address, :language, :neighborhood_id, :category_id])
    |> get_coordinates
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

  defp get_coordinates(changeset) do
    address = changeset.data.address
    { :ok, result } = Maps.geocode("#{address}, Oslo")
    coordinates = Enum.map(result["results"], fn (x) -> x["geometry"]["location"] end)
    %{ "lat" => lat, "lng" => lng } = Enum.at(coordinates, 0)
    changeset |> put_change(:lat, lat) |> put_change(:lng, lng)
  end
end
