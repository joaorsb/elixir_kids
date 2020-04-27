defmodule ElixirKidsWeb.PostsListLive do
  use Phoenix.LiveView
  alias ElixirKids.Blog
  alias ElixirKids.PubSub

  def mount(_params, _session, socket) do
    if connected?(socket), do: PubSub.subscribe_posts()

    posts = Blog.list_posts_by_order([desc: :inserted_at])
    socket = assign(socket, posts: posts)

    {:ok, socket}
  end

  def render(assigns) do
    Phoenix.View.render(ElixirKidsWeb.PostListView, "index.html", assigns)
  end

  def handle_info({:post, :create, post}, socket) do
    posts = [post | socket.assigns.posts]
    {:noreply, assign(socket, :posts, posts)}
  end

  def handle_info({:post, :update, post}, socket) do
    posts = update_in(socket.assigns.posts, [post.id, :title], (post.title))
    {:noreply, assign(socket, :posts, posts)}
  end

  def handle_info({:post, :delete, post}, socket) do
    posts =
      socket.assigns.posts
      |> Enum.reject(fn p -> p.id == post.id end)
    {:noreply, assign(socket, :posts, posts)}
  end
end
