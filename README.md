# ClassList

Web application to make school classroom directories. Built with Elixir and Phoenix.

## Setup
  * `mix ecto.setup`

This will create a default user with email `test@example.com` and a password of `secret` (configurable in `priv/repo/seeds.exs`). Login and delete this user and create a user with a secure password.

Next, create `Classes` and `Buses` from within the admin interface. Those models will populate selection options on the main data entry page. At this point users can enter their information and the directory can be generated.

## Interface
The main data entry point is served from `/`, it does not require a login. All administration is done from the `/admin` url, these paths do require a user login.

## Email Notifications
The app can send email to inform the maintainer that a new entry has been received. To use this feature, define the environment variables described below. The application uses [Mailgun](mailgun.com) to send email.

## Environment Variables
Define the following environment variables to enable certain features
  * `MAILGUN_DOMAIN`: as specified in the Mailgun control panel, something like `https://api.mailgun.net/v3/sandbox-our-domain.mailgun.org`
  * `MAILGUN_API_KEY`: as specified in the Mailgun control panel
  * `NOTIFY_EMAIL_TO` and `NOTIFY_EMAIL_FROM`: also need to be defined to use the Mailgun interface
  * `SUPPORT_EMAIL`: if defined, adds a line of help text with a `mailto` link in to the top of the page

## Heroku Setup
Follow this guide: http://www.phoenixframework.org/docs/heroku
  * heroku addons:create heroku-postgresql:hobby-dev
  * heroku config:set POOL_SIZE=18
  * mix phoenix.gen.secret
  * heroku config:set SECRET_KEY_BASE="XXXX"
  * heroku config:set MAILGUN_DOMAIN="XXXX"
  * heroku config:set MAILGUN_API_KEY="XXXX"
  * heroku config:set NOTIFY_EMAIL_TO="XXXX"
  * heroku config:set NOTIFY_EMAIL_FROM="XXXX"
  * heroku config:set SUPPORT_EMAIL="XXXX"

## License

See the [LICENSE](LICENSE.md) file for license rights and limitations (MIT).
