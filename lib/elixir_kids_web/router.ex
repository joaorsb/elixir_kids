defmodule ElixirKidsWeb.Router do
  use ElixirKidsWeb, :router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :live_layouts do
    plug :put_root_layout, {ElixirKidsWeb.LayoutView, :live }
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ElixirKidsWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/categories", CategoryController
    resources "/posts", PostController
    resources "/medias", MediaController
    resources "/neighborhoods", NeighborhoodController
  end

  scope "/live", ElixirKidsWeb do
    pipe_through [:browser, :live_layouts]

    live "/neighborhoods/new", NeighborhoodLive.New
    live "/neighborhoods/:id", NeighborhoodLive.Show
    live "/neighborhoods/:id/edit", NeighborhoodLive.Edit
    live "/neighborhoods", NeighborhoodLive.Index
  end

  # Other scopes may use custom stacks.
  # scope "/api", ElixirKidsWeb do
  #   pipe_through :api
  # end
end
