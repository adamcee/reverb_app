use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :reverb_server, ReverbServerWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :reverb_server, ReverbServer.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "reverb_server_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# IF we want, we can Use mock data via HTTPClient.InMemory to simulate HTTP requests
# See: http://blog.plataformatec.com.br/2015/10/mocks-and-explicit-contracts/
# config :reverb_server, http_client: ReverbServer.HTTPClient.InMemory
config :reverb_server, http_client: ReverbServer.HTTPClient.HTTPotion
