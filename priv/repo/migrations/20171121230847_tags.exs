defmodule Wiki.Repo.Migrations.Tags do
  use Ecto.Migration

  def change do
    create table(:games_tags, primary_key: false) do
      add :game_id, references(:games)
      add :tag_id, references(:tags)
    end
  end
end
