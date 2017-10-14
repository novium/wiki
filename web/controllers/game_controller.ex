defmodule Wiki.GameController do
  use Wiki.Web, :controller
  alias Wiki.Game

  def index(conn, _params) do
    conn |> text("Here you should be able to search for games")
  end

  def show(conn, _params = %{"slug" => slug}) do
    case Repo.get(Game, slug) do
      nil -> conn |> text("Game doesnt exist")
      game -> conn |> render("game.html", game: game)
    end
  end

  def create(conn = %{method: "GET"}, _params) do
    changeset = Game.changeset(%Game{})
    conn
    |> render("create.html", changeset: changeset)
  end

  def create(conn = %{method: "POST"},
  _params = %{"game" => game}) do
    changeset = Game.changeset(%Game{}, game)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Created game")
      |> redirect(to: "/")
    else
      conn
      |> render("create.html", changeset: changeset)
    end
  end


  defp from_slug(slug) do
    slug |> String.replace("-", " ")
  end

  defp random_string() do
    Ecto.UUID.generate |> binary_part(0,8)
  end
end
