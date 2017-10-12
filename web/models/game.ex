defmodule Wiki.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :name, :string
    field :description, :string
    field :release, :integer     # year of release
    field :boxart, :string       # Should be replaced with id on S3

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description, :release, :boxart])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
