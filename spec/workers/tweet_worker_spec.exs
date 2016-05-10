defmodule AnyoneImportant.TweetWorkerSpec do
  use ESpec
  use Timex
  alias AnyoneImportant.TweetWorker
  alias AnyoneImportant.TwitterService
  alias AnyoneImportant.EmailService
  alias AnyoneImportant.User
  alias AnyoneImportant.ImportantPerson
  alias AnyoneImportant.Repo

  describe "handle_info" do
    let :user_email, do: "lilsqueak@example.com"
    let :user_handle, do: "@lilsqueeker"
    let :important_person_handle, do: "@bigdog"
    let :matching_tweet, do: "RT @kanyewest: Please: Do everything you possibly can in one lifetime."

    before do
      search_results = [matching_tweet, "I feel like @kanyewest. Know its crazy crazy but one day bro.. one day"]
      
      allow(TwitterService).to accept(:search, fn(important_person_handle, "@lilsqueeker") -> search_results end)
      allow(EmailService).to accept(:send, fn(user_email, matching_tweet) -> nil end)

      %User{name: user_handle, email: user_email}
      |> Repo.insert!

      %ImportantPerson{handle: important_person_handle}
      |> Repo.insert!
    end

    it "sends to user for the first time"do
      TweetWorker.handle_info(:work, %{})

      updated_user = Repo.all(User)
        |> Enum.filter(fn(user) -> user.email == user_email end)
        |> List.first

      expect EmailService |> to(accepted :send, [user_email, matching_tweet])
      expect(TwitterService).to accepted(:search, ["#{important_person_handle}:", user_handle])

      Timex.diff(updated_user.last_email_sent_at, DateTime.now, :sec) |> should(be_close_to 0, 1)
    end

    it "sends if last_email sent is more than a day in the past" do
      user = Repo.all(User)
              |> Enum.filter(fn(user) -> user.email == user_email end)
              |> List.first
      user = Ecto.Changeset.change user, last_email_sent_at: Timex.shift(DateTime.now, days: -2)
      Repo.update user

      TweetWorker.handle_info(:work, %{})

      expect(EmailService).to accepted :send
    end

    it "does not send emails to users that have an email sent in the last day" do
      user = Repo.all(User)
              |> Enum.filter(fn(user) -> user.email == user_email end)
              |> List.first
       user = Ecto.Changeset.change user, last_email_sent_at: DateTime.now
       Repo.update user

       TweetWorker.handle_info(:work, %{})

       expect TwitterService |> to_not(accepted :search)
       expect EmailService |> to_not(accepted :send)
    end
  end
end
