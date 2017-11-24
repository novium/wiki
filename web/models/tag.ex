defmodule Wiki.Tag do
  use Wiki.Web, :model

  schema "tags" do
    field :tag, :string

    many_to_many :games, Wiki.Game, join_through: "games_tags"
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:tag])
    |> validate_required([:tag])
  end
end
