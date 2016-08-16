defmodule Coders.GithubUsers do
  @github_url Application.get_env(:coders, :github_url)

  def fetch(location, language) do
    url(location, language)
      |> HTTPotion.get([headers: ["User-Agent": "Elixir App"]])
      |> handle_response
  end

  def url("", "") do
    "#{@github_url}/search/users?q=+type:user&sort=repositories&order=desc"
  end

  def url(location, "") do
    "#{@github_url}/search/users?q=+type:user+location:#{location}&sort=repositories&order=desc"
  end

  def url("", language) do
    "#{@github_url}/search/users?q=+type:user+language:#{language}&sort=repositories&order=desc"
  end

  def url(location, language) do
    "#{@github_url}/search/users?q=+type:user+location:#{location}+language:#{language}&sort=repositories&order=desc"
  end

  def handle_response(%{body: body, status_code: 200}) do
    {:ok, JSON.decode!(body)}
  end

  def handle_response(%{body: body, status_code: _}) do
    {:error, JSON.decode!(body)}
  end
end
