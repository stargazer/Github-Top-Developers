defmodule Coders.GithubUsers do

  def fetch(location, language) do
    url(location, language)
      |> HTTPotion.get([headers: ["User-Agent": "Elixir App"]])
      |> handle_response
  end

  def url(location, language) do
    "https://api.github.com/search/users?q=+type:user+location:#{location}+language:#{language}"
  end

  def handle_response(%{body: body, status_code: 200}) do
    {:ok, JSON.decode(body)}
  end

  def handle_response(%{body: body, status_code: _}) do
    {:error, JSON.decode(body)}
  end
end
