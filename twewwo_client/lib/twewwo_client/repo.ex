defmodule TwewwoClient.Repo do
  use Ecto.Repo,
    otp_app: :twewwo_client,
    adapter: Ecto.Adapters.Postgres
end
