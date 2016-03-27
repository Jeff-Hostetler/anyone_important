defmodule AnyoneImportant.EmailService do
  use Mailgun.Client,
    domain: Application.get_env(:anyone_important, :mailgun_domain),
    key: Application.get_env(:anyone_important, :mailgun_key)

  def send(email_address, content) do
     send_email to: email_address,
                  from: "anyoneimportant@example.com",
                  subject: "You must be important",
                  text: content
  end

end