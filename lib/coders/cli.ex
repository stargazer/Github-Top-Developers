defmodule Coders.CLI do

  @default_language "Python"

  def run(argv) do
    parse_args(argv)
      |> process
  end

  @doc """
  `argv` can be -h or --help, which returns :help.
  Otherwise it is a location (mandatory) and language (optional).
  Returns a tuple of 
    `{ location, language }` or 
    `{ location }` or 
    `:help`
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean ],
                                     aliases:  [ h:    :help   ])
    case parse do
      { [help: true], _, _ }           ->    :help
      { _, [ location, language ], _ } ->    { location, language }
      { _, [ location ], _ }           ->    { location, @default_language }
      _                                ->    :help
    end
  end

  def process(:help) do
    IO.puts """
      usage: coders <location> [ language | #{@default_language} ]
    """
    System.halt(0)
  end

  def process({location, language}) do
    Coders.GithubUsers.fetch(location, language)
  end

end
