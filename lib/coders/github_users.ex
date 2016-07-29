defmodule Coders.GithubUsers do

  def fetch(location, language) do
    url(location, language)
      |> HTTPoison.get
      |> handle_response
  end

  def url(location, language) do
    "https://api.github.com/search/users?q=+type:user+location:#{location}+language:#{language}"
  end

  def handle_response({ :ok, %{body: body} }) do
    {:ok, :jsx.decode(body)}
  end

  def handle_response({ :error, %{body: body} }) do 
    {:error, :jsx.decode(body)}
  end
end
