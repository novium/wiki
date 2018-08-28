defmodule Wiki.GameController do
  use Wiki.Web, :controller
  alias Wiki.Game
  alias Wiki.SteamGame

  def index(conn, _params) do
    conn |> text("Here you should be able to search for games")
  end

  def show(conn, _params = %{"slug" => slug}) do
    case Repo.get(Game, from_slug slug) do
      nil -> conn |> text("Game doesnt exist")
      game ->
        conn |> render("game.html", game: game, tags: Repo.all(assoc(game, :tags)))
    end
  end

  def create(conn = %{method: "GET"}, _params) do
    changeset = Game.changeset(%Game{})
    conn
    |> render("create.html", changeset: changeset)
  end

  def search_steam(conn, _params = %{"name" => name}) do
    query = from g in SteamGame,
      where: fragment("? SOUNDS LIKE ?", ^name, g.name),
      order_by: [asc: g.appid],
      limit: 7,
      select: map(g, [:appid, :name])

    case Repo.all(query) do
      [] -> conn |> json %{"error" => "nothing found"}
      games -> conn |> json games
    end
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
    slug |> String.split("-") |> List.last
  end

  defp random_string() do
    Ecto.UUID.generate |> binary_part(0,8)
  end
end
