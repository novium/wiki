defmodule Wiki.Router do
  use Wiki.Web, :router
  require Ueberauth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :cors do
    plug CORSPlug, origin: ["http://10.0.75.2"]
  end

  scope "/", Wiki do
    pipe_through [:browser, :cors] # Use the default browser stack

    get "/", PageController, :index

    get "/game", GameController, :index
    get "/game/create", GameController, :create
    get "/game/:slug", GameController, :show
    post "/game/create", GameController, :create
  end

  # API's
  scope "/", Wiki do
    pipe_through [:api]
    
    get "/game/search_steam/:name", GameController, :search_steam
  end

  scope "/auth", Wiki do
    pipe_through :browser

    get "/", AuthController, :index
    get "/exit", AuthController, :signout

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", Wiki do
  #   pipe_through :api
  # end
end
