defmodule AnyoneImportant.EmailServiceSpec do
  use ESpec
  alias AnyoneImportant.EmailService

  describe "send" do
    it "does not blow up when the email is sent" do
      EmailService.send("me@example.com", "some content")
    end
  end
end