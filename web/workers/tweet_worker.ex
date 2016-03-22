defmodule AnyoneImportant.TweetWorker do
  use GenServer
  alias AnyoneImportant.TwitterService
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
    # Do the work you desire here

    user_handles = Repo.all(User)
    |> Enum.map(fn(user) -> user.name end)

    important_people_handles = Repo.all(ImportantPerson)
    |> Enum.map(fn(person) -> person.handle end)

    Enum.each(important_people_handles, fn(important_handle) ->
      Enum.each(user_handles, fn(user_handle) ->
        tweets = TwitterService.search("#{important_handle}:", user_handle)

        first_record = List.first(tweets)

        if first_record != nil do
          IO.puts first_record
        end
      end)
    end)

    # Start the timer again
    Process.send_after(self(), :work, 30 * 1000) # In 30 seconds

    {:noreply, state}
  end
end
