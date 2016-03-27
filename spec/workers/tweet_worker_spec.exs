defmodule AnyoneImportant.TweetWorkerSpec do
  use ESpec
  alias AnyoneImportant.TweetWorker
  alias AnyoneImportant.TwitterService
  alias AnyoneImportant.EmailService
  alias AnyoneImportant.User
  alias AnyoneImportant.ImportantPerson
  alias AnyoneImportant.Repo

  context "worker runs" do
    let :important_person_handle, do: "@bigdog"
    let :user_handle, do: "@lilsqueeker"
    let :user_email, do: "lilsqueak@example.com"
    let :matching_tweet, do: "RT @kanyewest: Please: Do everything you possibly can in one lifetime."
    let :search_results do
      [matching_tweet,
       "I feel like @kanyewest. Know its crazy crazy but one day bro.. one day"]
    end
    before do
      allow(TwitterService).to accept(:search, fn(important_person_handle, user_handle) -> search_results end)
      allow EmailService |> to(accept :send, fn(user_email, matching_tweet) -> nil end)

      %User{name: user_handle, email: user_email}
      |> Repo.insert!

      %ImportantPerson{handle: important_person_handle}
      |> Repo.insert!

      TweetWorker.handle_info(:work, %{})
    end

    it do: expect EmailService |> to(accepted :send)
  end
end
