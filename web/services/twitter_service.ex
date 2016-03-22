defmodule AnyoneImportant.TwitterService do

  def search(twitter_handle, search_term) do
    search_result = ExTwitter.search(search_term, [count: 10]) |>
       Enum.map(fn(tweet) -> tweet.text end)

    Enum.to_list(search_result)
  end
end

search_result = ExTwitter.search("kanye", [count: 10]) |>
       Enum.map(fn(tweet) -> tweet.text end)

    Enum.to_list(search_result)