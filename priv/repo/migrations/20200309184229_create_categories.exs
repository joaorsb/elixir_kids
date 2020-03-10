defmodule ElixirKids.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :title, :string
      add :slug, :string
      add :type, :string

      timestamps()
    end

  end
end
