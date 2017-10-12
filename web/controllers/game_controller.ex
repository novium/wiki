defmodule Wiki.GameController do
  use Wiki.Web, :controller
  alias Wiki.Game

  def index(conn, _params) do
    conn |> text("Here you should be able to search for games")
  end

  def show(conn, _params) do
    conn
    |> put_flash(:info, "not yet implemented")
    |> redirect(to: "/")
  end

  def create(conn = %{method: "GET"}, _params) do
    changeset = Game.changeset(%Game{})
    conn
    |> render("create.html", changeset: changeset)
  end
end
