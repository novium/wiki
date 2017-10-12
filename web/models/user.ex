defmodule Wiki.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :coreid, :binary_id
    field :email, :string
    field :nick, :string
    field :token, :string
    field :refresh_token, :string
    field :expires, :naive_datetime

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:coreid, :email, :nick, :token, :refresh_token, :expires])
    |> validate_required([:coreid, :email, :token, :refresh_token, :expires])
    |> unique_constraint(:coreid)
  end
end