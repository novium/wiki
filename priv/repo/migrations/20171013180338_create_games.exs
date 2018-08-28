defmodule Wiki.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :name, :string
      add :description, :text
      add :release, :integer
      add :boxart, :string
      add :platform, :string

      add :about, :text
      add :help, :text

      timestamps()
    end

    create unique_index(:games, [:name, :release])
  end
end
