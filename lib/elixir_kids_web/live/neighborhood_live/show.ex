defmodule ElixirKidsWeb.NeighborhoodLive.Show do
  use Phoenix.LiveView

  alias Phoenix.LiveView.Socket
  alias ElixirKidsWeb.Router.Helpers, as: Routes
  alias ElixirKids.Blog
  alias ElixirKids.PubSub
  alias ElixirKidsWeb.NeighborhoodLive

  def render(assigns), do: Phoenix.View.render(ElixirKidsWeb.NeighborhoodView, "show.html", assigns)

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _url, socket) do
    if connected?(socket), do: PubSub.subscribe_neighborhoods()
    try do
      neighborhood = Blog.get_neighborhood!(id)
      {:noreply, assign(socket, neighborhood: neighborhood) }
    rescue
      Ecto.NoResultsError ->
        {:noreply,
          socket
          |> put_flash(:error, "Neighborhood not found!")
          |> redirect(to: Routes.live_path(socket, NeighborhoodLive.Index))
        }
    end
  end

  def handle_info({:neighborhood, :update, neighborhood}, socket) do
    new_neighborhood = Blog.get_neighborhood!(neighborhood.id)
    {:noreply, assign(socket, neighborhood: new_neighborhood)}
  end

  def handle_info({:neighborhood, :delete, _}, socket) do
    {:stop,
      socket
      |> put_flash(:info, "Neighborhood deleted!")
      |> redirect(to: Routes.live_path(socket, NeighborhoodLive.New))
    }
  end

end
