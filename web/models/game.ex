defmodule Wiki.Game do
  use Wiki.Web, :model

  schema "games" do
    field :name, :string
    field :description, :string

    field :release, :integer, default: 2012

    field :boxart, :string       # Should be replaced with id on S3

    many_to_many :tags, Wiki.Tag, join_through: "games_tags"
    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description, :release, :boxart])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
