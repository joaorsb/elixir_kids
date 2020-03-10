defmodule ElixirKidsWeb.PageController do
  use ElixirKidsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
