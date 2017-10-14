defmodule Wiki.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :name, :string
      add :description, :string
      add :release, :integer
      add :boxart, :string

      timestamps()
    end

    create unique_index(:games, [:name, :release])
  end
end
