defmodule AnyoneImportant.TweetWorker do
  use GenServer
  alias AnyoneImportant.TwitterService
  alias AnyoneImportant.EmailService
  alias AnyoneImportant.User
  alias AnyoneImportant.ImportantPerson
  alias AnyoneImportant.Repo

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    Process.send_after(self(), :work,  1 * 1000) # In 1 seconds
    {:ok, state}
  end

  def handle_info(:work, state) do
    users = Repo.all(User)

    important_people_handles = Repo.all(ImportantPerson)
    |> Enum.map(fn(person) -> person.handle end)

    Enum.each(important_people_handles, fn(important_handle) ->
      Enum.each(users, fn(user) ->
        tweets = TwitterService.search("#{important_handle}:", user.name)

        first_record = List.first(tweets)

        if first_record != nil do
          EmailService.send(user.email, first_record)
        end
      end)
    end)

    # Start the timer again
    Process.send_after(self(), :work, 3 * 60 * 1000) # In 3 minutes

    {:noreply, state}
  end
end
