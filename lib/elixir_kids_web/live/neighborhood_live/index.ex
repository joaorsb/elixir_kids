defmodule ElixirKidsWeb.NeighborhoodLive.Index do
  use Phoenix.LiveView

  alias ElixirKids.Blog
  alias ElixirKids.NeighborhoodView
  alias ElixirKidsWeb.Router.Helpers, as: Routes
  alias ElixirKids.PubSub

  def render(assigns), do: Phoenix.View.render(ElixirKidsWeb.NeighborhoodView, "index.html", assigns)

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page: 1)}
  end

  def handle_params(params, _url, socket) do
    if connected?(socket), do: PubSub.subscribe_neighborhoods()
    {page, ""} = Integer.parse(params["page"] || "1")
    {:noreply, socket |> assign(page: page) |> fetch()}
  end

  defp fetch(socket) do
    %{page: page} = socket.assigns
    neighborhoods = Blog.list_neighborhoods(page, 10)
    assign(socket, neighborhoods: neighborhoods)
  end

  def handle_event("keydown", %{"code" => "ArrowLeft"}, socket) do
    {:noreply, go_page(socket, socket.assigns.page - 1)}
  end

  def handle_event("keydown", %{"code" => "ArrowRight"}, socket) do
    {:noreply, go_page(socket, socket.assigns.page + 1)}
  end

  def handle_event("keydown", _, socket) do
    {:noreply, socket}
  end

  def handle_event("delete_neighborhood", %{"id" => id}, socket) do
    neighborhood = Blog.get_neighborhood!(id)
    {:ok, _neighborhood} = Blog.delete_neighborhood(neighborhood)
    neighborhoods =
      socket.assigns.neighborhoods
      |> Enum.reject(fn n -> n.id == neighborhood.id end)
    { :noreply, assign(socket, neighborhoods: neighborhoods) }
  end

  def handle_info({:neighborhood, :delete, neighborhood}, socket) do
    neighborhoods =
      socket.assigns.neighborhoods
      |> Enum.reject(fn n -> n.id == neighborhood.id end)
    { :noreply, assign(socket, neighborhoods: neighborhoods) }
  end

  def handle_info({:neighborhood, :create, _neighborhood}, socket) do
    {:noreply, fetch(socket)}
  end

  defp go_page(socket, page) when page > 0 do
    push_patch(socket, to: Routes.live_path(socket, __MODULE__, page))
  end

  defp go_page(socket, _page), do: socket
end
