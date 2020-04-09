defmodule ElixirKidsWeb.PageController do
  use ElixirKidsWeb, :controller
  alias alias ElixirKids.Blog

  def index(conn, _params) do
    posts = Blog.list_posts_by_order([desc: :inserted_at])
    render(conn, "index.html", posts: posts)
  end
end
