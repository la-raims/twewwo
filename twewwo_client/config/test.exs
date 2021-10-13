use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :twewwo_client, TwewwoClient.Repo,
  # username: "postgres",
  # password: "postgres",
  # database: "twewwo_client_test#{System.get_env("MIX_TEST_PARTITION")}",
  # hostname: "localhost",
  url: System.get_env("DATABASE_URL") |> String.replace("?", "test"),
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :twewwo_client, TwewwoClientWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
