use Mix.Config

#import api keys that are useful in all environments
import_config "secrets.exs"

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :anyone_important, AnyoneImportant.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :anyone_important, AnyoneImportant.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "anyone_important_test",
  hostname: "localhost",
  mailgun_domain: "test.org",
  mailgun_key: "secret-key",
  pool: Ecto.Adapters.SQL.Sandbox
