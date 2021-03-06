defmodule Coders.CLI do
  import Coders.TableFormatter, only: [print_table: 2]

  @default_fields   ["login", "url", "score"]

  def main(argv) do
    parse_args(argv)
      |> process
      |> filter_response
      |> print_table(@default_fields)
  end


  @doc """
  `argv` can be:
    * -h or --help, which returns :help.
    * --location=LOCATION or -loc <LOCATION>
    * --language=LANGUAGE or -lan <LANGUAGE>

  Returns either:
    * `:help`
    * %{ location: <LOCATION>, language: <LANGUAGE> }
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help:     :boolean, 
                                                 location: :string, 
                                                 language: :string ],
                                     aliases:  [ h:        :help,
                                                 loc:      :location,
                                                 lan:      :language ])
    case parse do
      { [help: true], _, _ } -> :help
      { options     , _, _ } -> Keyword.put_new(options, :location, "")
                               |> Keyword.put_new(:language, "")
                               |> Enum.into(Map.new)
    end
  end

  def process(:help) do
    IO.puts """
      usage: gtd --location=<LOCATION> --language=<LANGUAGE>
    """
    System.halt(0)
  end

  def process( %{ location: location, language: language }) do
    Coders.GithubUsers.fetch(location, language)
      |> decode_response
  end


  def decode_response({:ok, body}), do: body

  def decode_response({:error, error}) do
    {_, message} = List.keyfind(error, "message", 0)
    IO.puts "Error fetching from Github: #{message}"
    System.halt(2)
  end


  @doc """
  `body` is the a map with Github API's response. It has the form:
  {
    "total_count": 12,
    "incomplete_results": false,
    "items": [
      { "login": "mojombo", "id": 1, "url": "https://api.github.com/users/mojombo", "score": 105.47857, ...},
      { ... },
    ]
  }
  This function returns the content of the `items` key
  """
  def filter_response(body) do
    Map.get(body, "items")
  end

end

