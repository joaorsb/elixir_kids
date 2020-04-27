defmodule ElixirKidsWeb.NeighborhoodLive.New do
  use Phoenix.LiveView

  alias ElixirKidsWeb.NeighborhoodLive
  alias ElixirKids.Blog
  alias ElixirKids.PubSub
  alias ElixirKids.Blog.Neighborhood
  alias ElixirKidsWeb.Router.Helpers, as: Routes

  def mount(_params, _session, socket) do
    if connected?(socket), do: PubSub.subscribe_neighborhoods()

    changeset = Blog.change_neighborhood(%Neighborhood{})
    {:ok, assign(socket, changeset: changeset)}
  end

  def render(assigns), do: Phoenix.View.render(ElixirKidsWeb.NeighborhoodView, "new.html", assigns)

  def handle_event("validate", %{"neighborhood" => neighborhood_params}, socket) do
    changeset =
      %Neighborhood{}
      |> Blog.change_neighborhood(neighborhood_params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"neighborhood" => neighborhood_params}, socket) do
    case Blog.create_neighborhood(neighborhood_params) do
      {:ok, neighborhood } ->
        {:noreply,
          socket
          |> put_flash(:info, "Neighborhood created")
          |> redirect(to: Routes.live_path(socket, NeighborhoodLive.Show, neighborhood))
        }

      {:error, %Ecto.Changeset{} = changeset } ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
