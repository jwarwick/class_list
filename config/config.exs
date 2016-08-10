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

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"