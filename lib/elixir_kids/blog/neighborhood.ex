defmodule ElixirKids.Blog.Neighborhood do
  use Ecto.Schema
  import Ecto.Changeset

  alias GoogleMaps, as: Maps

  schema "neighborhoods" do
    field :latitude, :float
    field :longitude, :float
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(neighborhood, attrs) do
    neighborhood
    |> cast(attrs, [:name, :latitude, :longitude])
    |> validate_required([:name])
    |> get_coordinates
  end

  defp get_coordinates(changeset) do
    name = changeset.data.name
    { :ok, result } = Maps.geocode("#{name}, Oslo")
    coordinates = Enum.map(result["results"], fn (x) -> x["geometry"]["location"] end)
    %{ "lat" => lat, "lng" => lng } = Enum.at(coordinates, 0)
    changeset |> put_change(:latitude, lat) |> put_change(:longitude, lng)
  end
end
