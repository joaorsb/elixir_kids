defmodule ElixirKids.PubSub do
  alias Phoenix.PubSub

  @posts_topic "posts"
  @neighborhoods_topic "neighborhoods"

  def subscribe_posts() do
    PubSub.subscribe(ElixirKids.PubSub, @posts_topic)
  end

  def subscribe_neighborhoods() do
    PubSub.subscribe(ElixirKids.PubSub, @neighborhoods_topic)
  end

  def subscribe_neighborhood(id) do
    PubSub.subscribe(ElixirKids.PubSub, @neighborhoods_topic <> "#{id}")
  end

  def broadcast_post(type, post) when type in [:create, :update, :delete] do
    message = {:post, type, post}
    PubSub.broadcast(ElixirKids.PubSub, @posts_topic, message)
  end

  def broadcast_neighborhoods({:ok, result }, type ) when type in [:create, :update, :delete] do
    message = {:neighborhood, type, result}
    PubSub.broadcast(ElixirKids.PubSub, @neighborhoods_topic, message)
    {:ok, result }
  end
end
