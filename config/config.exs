# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :class_list,
  ecto_repos: [ClassList.Repo]

# Configures the endpoint
config :class_list, ClassList.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pUMQHUxp7jca62JaYHc+YfGUD/atoEUxrRYLSgpy7mGSSSoQ6nw5X1rf01AhWOgF",
  render_errors: [view: ClassList.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ClassList.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Email support via Mailgun
config :class_list,
  mailgun_domain: System.get_env("MAILGUN_DOMAIN"),
  mailgun_key: System.get_env("MAILGUN_API_KEY"),
  notify_to: System.get_env("NOTIFY_EMAIL_TO"),
  notify_from: System.get_env("NOTIFY_EMAIL_FROM")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: ClassList.User,
  repo: ClassList.Repo,
  module: ClassList,
  logged_out_url: "/",
  opts: [:authenticatable]
# %% End Coherence Configuration %%
