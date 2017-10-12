defmodule GuardianSerializer do
  @moduledoc """
  Contains the serializer for guardian
  """
  alias Wiki.Repo

  def for_token(user = %Wiki.User{}) do
    {:ok, "#{user.coreid}"}
  end

  def from_token(token) do
    case Repo.get_by(Wiki.User, coreid: token) do
      nil -> {:error, "No user"}
      user -> {:ok, {:ok, user}}
    end
  end
end
