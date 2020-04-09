defmodule ElixirKids.Repo.Migrations.AddNeighborhoodToPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      remove :neighborhood
      add :neighborhood_id, references(:neighborhoods)
    end
  end
end
