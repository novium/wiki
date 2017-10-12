defmodule Wiki.AuthController do
  use Wiki.Web, :controller
  plug Ueberauth
  alias Ueberauth.Strategy.Helpers

  def request(conn, _params) do
    conn
  end

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate. #{inspect _fails}")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case find_or_create(auth) do
      {:ok, user} ->
        conn
        |> Guardian.Plug.sign_in(user)
        |> put_flash(:info, "Hooray! Logged in!")
        |> redirect(to: "/")
      {:error, reason} ->
        conn
        |> put_flash(:error, "Something went wrong")
        |> redirect(to: "/")
    end

    conn
    |> put_flash(:info, "Logged in: #{inspect auth}")
    |> redirect(to: "/")
  end

  defp find_or_create(auth) do
    case Repo.get_by(Wiki.User, coreid: auth.uid) do
      nil -> create(auth)
      user -> {:ok, user}
    end
  end

  defp create(auth) do
    changeset = Wiki.User.changeset(%Wiki.User{
      coreid: auth.uid,
      email: auth.info.email,
      nick: auth.info.nickname,
      token: auth.credentials.token,
      refresh_token: auth.credentials.refresh_token,
      expires: NaiveDateTime.add(~N[1970-01-01 00:00:00], auth.credentials.expires_at)
    })

    case Repo.insert(changeset) do
      {:ok, user} -> {:ok, user}
      {:error, changeset} ->
        Repo.rollback(changeset)
        {:error, "Something went wrong inserting user"}
    end
  end
end
