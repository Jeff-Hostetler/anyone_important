defmodule AnyoneImportant.TweetWorkerSpec do
  use ESpec
  alias AnyoneImportant.TweetWorker
  alias AnyoneImportant.TwitterService
  alias AnyoneImportant.User
  alias AnyoneImportant.ImportantPerson
  alias AnyoneImportant.Repo

  context "worker runs" do
    let :important_person_handle, do: "@bigdog"
    let :user_handle, do: "@lilsqueeker"
    let :search_result do
      ["RT @kanyewest: Please: Do everything you possibly can in one lifetime.",
       "I feel like @kanyewest. Know its crazy crazy but one day bro.. one day"]
    end
    before do
      allow(TwitterService).to accept(:search, fn(important_person_handle, user_handle) -> search_result end)

      %User{name: user_handle, email: "jhizzo@example.com"}
      |> Repo.insert

      %ImportantPerson{handle: important_person_handle}
      |> Repo.insert
    end

    subject do: TweetWorker.start_link
  end
end