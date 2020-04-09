defmodule ElixirKids.Repo.Migrations.CreateNeighborhoods do
  use Ecto.Migration

  def change do
    create table(:neighborhoods) do
      add :name, :string
      add :latitude, :float
      add :longitude, :float

      timestamps()
    end

  end
end
