defmodule ClassList.Mailer do
  @moduledoc """
  Interface to Mailgun to send notification emails
  """

  require Logger
  use Mailgun.Client,
    domain: Application.get_env(:class_list, :mailgun_domain),
    key: Application.get_env(:class_list, :mailgun_key)#,
    # mode: :test,
    # test_file_path: "/tmp/mailgun.json"

  @notify_to System.get_env("NOTIFY_EMAIL_TO")
  @notify_from System.get_env("NOTIFY_EMAIL_FROM")

  def send_notification_email(content) do
    result = send_email(
      to: @notify_to,
      from: @notify_from,
      subject: "User Signup",
      text: "New user data:\n #{inspect content}"
      )

    case result do
      {:ok, _} -> :ok
      _ -> Logger.error "Failed to send email: #{inspect result}"
    end
  end
end
