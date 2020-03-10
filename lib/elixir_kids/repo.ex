defmodule ElixirKids.Repo do
  use Ecto.Repo,
    otp_app: :elixir_kids,
    adapter: Ecto.Adapters.Postgres
end
