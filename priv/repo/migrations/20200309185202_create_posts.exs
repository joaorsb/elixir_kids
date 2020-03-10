defmodule ElixirKids.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :description, :string
      add :address, :string
      add :image_name, :string, null: true
      add :lat, :float
      add :lng, :float
      add :neighborhood, :string
      add :site_url, :string
      add :slug, :string
      add :language, :string
      add :category_id, references(:categories)

      timestamps()
    end

  end
end
