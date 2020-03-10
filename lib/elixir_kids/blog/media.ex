defmodule ElixirKids.Blog.Media do
  use Ecto.Schema
  import Ecto.Changeset

  schema "medias" do
    field :name, :string
    field :post_id, :integer
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(media, attrs) do
    media
    |> cast(attrs, [:name, :post_id, :type])
    |> validate_required([:name, :post_id, :type])
  end
end
