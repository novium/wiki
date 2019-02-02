defmodule Wiki.Guardian do
  @moduledoc """
  Contains the serializer for guardian
  """
  use Guardian, otp_app: :wiki
  alias Wiki.Repo

  def subject_for_token(user = %Wiki.User{}, _claims) do
    {:ok, "#{user.coreid}"}
  end

  def resource_from_claims(claims) do
    case Repo.get_by(Wiki.User, coreid: claims["sub"]) do
      nil -> {:error, "No user"}
      user -> {:ok, {:ok, user}}
    end
  end
end
