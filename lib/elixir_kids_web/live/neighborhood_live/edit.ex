defmodule ElixirKidsWeb.NeighborhoodLive.Edit do
  use Phoenix.LiveView

  alias ElixirKidsWeb.Router.Helpers, as: Routes
  alias ElixirKids.Blog
  alias ElixirKidsWeb.NeighborhoodLive
  alias ElixirKids.PubSub

  def render(assigns), do: ElixirKidsWeb.NeighborhoodView.render("edit.html", assigns)

  def mount(_params, _session, socket) do
    { :ok, socket }
  end

  def handle_params(%{"id" => id}, _url, socket) do
    if connected?(socket), do: PubSub.subscribe_neighborhoods()
    neighborhood = Blog.get_neighborhood!(id)
    {:noreply, assign(socket, neighborhood: neighborhood, changeset: Blog.change_neighborhood(neighborhood))}
  end

  def handle_event("validate", %{"neighborhood" => neighborhood_params}, socket) do
    changeset =
      socket.assigns.neighborhood
      |> Blog.change_neighborhood(neighborhood_params)
      |> Map.put(:action, :update)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"neighborhood" => neighborhood_params}, socket) do
    case Blog.update_neighborhood(socket.assigns.neighborhood, neighborhood_params) do
      {:ok, neighborhood} ->
        {:noreply,
          socket
          |> put_flash(:info, "Neighborhood updated!")
          |> redirect(to: Routes.live_path(socket, NeighborhoodLive.Show, neighborhood))
        }

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  def handle_info({:neighborhood, :update, _neighborhood}, socket) do
    {:noreply,
      socket
      |> put_flash(:info, "Neighborhood being edited in by another user")
    }
  end

  def handle_info({:neighborhood, :delete, _}, socket) do
    {:stop,
      socket
      |> put_flash(:info, "Neighborhood deleted!")
      |> redirect(to: Routes.live_path(socket, NeighborhoodLive.Index))
    }
  end
end
