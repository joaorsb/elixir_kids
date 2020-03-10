defmodule ElixirKids.Repo.Migrations.CreateMedias do
  use Ecto.Migration

  def change do
    create table(:medias) do
      add :name, :string
      add :post_id, references(:posts)
      add :type, :string


      timestamps()
    end

  end
end
