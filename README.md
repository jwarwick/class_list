# ClassList

Web application to make school classroom directories. Built with Elixir and Phoenix.

## Setup
  * `mix ecto.setup`

This will create a default user with email `test@example.com` and a password of `secret` (configurable in `priv/repo/seeds.exs`). Login and delete this user and create a user with a secure password.

Next, create `Classes` and `Buses` from within the admin interface. Those models will populate selection options on the main data entry page. At this point users can enter their information and the directory can be generated.

## Interface
The main data entry point is served from `/`, it does not require a login. All administration is done from the `/admin` url, these paths do require a user login.

## Environment Variables
Define the following environment variables to enable certain features
  * (Not implemented yet) `SENDGRID_USERNAME` and `SENDGRID_PASSWORD`: to send email using the Heroku SendGrid Addon
  * (Not implemented yet) `NOTIFY_EMAIL_TO` and `NOTIFY_EMAIL_FROM`: also need to be defined to use the SendGrid Addon
  * `SUPPORT_EMAIL`: if defined, adds a line of help text with a `mailto` link in to the top of the page

## License

See the [LICENSE](LICENSE.md) file for license rights and limitations (MIT).
