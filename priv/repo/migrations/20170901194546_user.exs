defmodule Wiki.Repo.Migrations.User do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :coreid, :binary_id
      add :email, :string
      add :nick, :string
      add :token, :string
      add :refresh_token, :string
      add :expires, :naive_datetime

      timestamps()
    end

    create unique_index(:users, [:cid])
  end
end
