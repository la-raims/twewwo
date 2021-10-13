defmodule TwewwoApi.Repo do
  use Ecto.Repo,
    otp_app: :twewwo_api,
    adapter: Ecto.Adapters.Postgres
end
