use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :anyone_important, AnyoneImportant.Endpoint,
  secret_key_base: System.get_env("SECRET_KEY_BASE")


# Configure your database
config :anyone_important, AnyoneImportant.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: 20

config :extwitter, :oauth, [
   consumer_key: System.get_env("CONSUMER_KEY"),
   consumer_secret: System.get_env("CONSUMER_SECRET"),
   access_token: System.get_env("ACCESS_TOKEN"),
   access_token_secret: System.get_env("ACCESS_TOKEN_SECRET")
]

config :anyone_important,
   mailgun_domain: System.get_env("MAILGUN_DOMAIN"),
   mailgun_key: System.get_env("MAILGUN_KEY")