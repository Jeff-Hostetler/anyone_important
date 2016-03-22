defmodule AnyoneImportant.TwitterService do

  def search(twitter_handle, search_term) do
    ExTwitter.search(twitter_handle, [count: 10])
    |> Enum.map(fn(tweet) -> tweet.text end)
    |> Enum.filter(fn(tweet) -> String.contains?(tweet, search_term) end)
    |> Enum.to_list
  end

end
