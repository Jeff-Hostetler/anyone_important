defmodule AnyoneImportant.Router do
  use AnyoneImportant.Web, :router

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

  scope "/", AnyoneImportant do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/help", PageController, :help

    resources "/users", UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", AnyoneImportant do
  #   pipe_through :api
  # end
end
