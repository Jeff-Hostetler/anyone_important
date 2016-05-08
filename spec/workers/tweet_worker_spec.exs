defmodule AnyoneImportant.TweetWorkerSpec do
  use ESpec
  alias AnyoneImportant.TweetWorker
  alias AnyoneImportant.TwitterService
  alias AnyoneImportant.EmailService
  alias AnyoneImportant.User
  alias AnyoneImportant.ImportantPerson
  alias AnyoneImportant.Repo

  describe "handle_info" do
    let :user_email, do: "lilsqueak@example.com"

    before do
      important_person_handle = "@bigdog"
      matching_tweet = "RT @kanyewest: Please: Do everything you possibly can in one lifetime."
      search_results = [matching_tweet, "I feel like @kanyewest. Know its crazy crazy but one day bro.. one day"]
      
      allow(TwitterService).to accept(:search, fn(important_person_handle, "@lilsqueeker") -> search_results end)
      allow(EmailService).to accept(:send, fn(user_email, matching_tweet) -> nil end)

      %User{name: "@lilsqueeker", email: user_email}
      |> Repo.insert!

      %ImportantPerson{handle: important_person_handle}
      |> Repo.insert!
    end

    it "sends to user for the first time"do
      TweetWorker.handle_info(:work, %{})

      updated_user = Repo.all(User)
        |> Enum.filter(fn(user) -> user.email == user_email end)
        |> List.first


      expect EmailService |> to(accepted :send)
      #with what arguments?
      expect(updated_user.last_email_sent_at).to_not eq(nil)
      #be close to if I knew how to express 1.second in Elixir
    end

    it "does not send emails to users that have an email sent in the last day" do
      user = Repo.all(User)
              |> Enum.filter(fn(user) -> user.email == user_email end)
              |> List.first
       user = Ecto.Changeset.change user, last_email_sent_at: Ecto.DateTime.utc
       Repo.update user

       TweetWorker.handle_info(:work, %{})

       expect EmailService |> to_not(accepted :send)
    end

    it "sends if last_email sent is more than a day in the past" do
      user = Repo.all(User)
              |> Enum.filter(fn(user) -> user.email == user_email end)
              |> List.first
      user = Ecto.Changeset.change user, last_email_sent_at: Timex.shift(Date.today, days: -2)
      Repo.update user

      TweetWorker.handle_info(:work, %{})

      expect EmailService |> to(accepted :send)
    end
  end
end
