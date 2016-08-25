defmodule ClassList.Mailer do
  @moduledoc """
  Interface to Mailgun to send notification emails
  """

  require Logger
  use Mailgun.Client,
    domain: Application.get_env(:class_list, :mailgun_domain),
    key: Application.get_env(:class_list, :mailgun_key)

  @notify_to Application.get_env(:class_list, :notify_to)
  @notify_from Application.get_env(:class_list, :notify_from)

  def send_notification_email(content) do
    result = send_email(
      to: @notify_to,
      from: @notify_from,
      subject: "User Signup",
      text: "New user data:\n #{inspect content}"
      )

    case result do
      {:ok, _} -> Logger.debug "Sent notification email to #{@notify_to}: #{inspect content}"
      _ -> Logger.error "Failed to send email: #{inspect result}"
    end
  end
end
