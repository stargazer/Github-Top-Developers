defmodule Coders.GithubUsers do

  def fetch(location, language) do
    url(location, language)
      |> HTTPoison.get
      |> handle_response
  end

  def url(location, language) do
    "https://api.github.com/search/users?q=+type:user+location:#{location}+language:#{language}"
  end

  def handle_response({:ok, response}), do: { :ok, response }
  def handle_response({:error, reason}), do: { :error, reason }
end
