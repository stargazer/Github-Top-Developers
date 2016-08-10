defmodule CliTest do
  use ExUnit.Case
  import Coders.CLI, only: [parse_args: 1]

  test "return :help by option parsing with -h and --help options" do
    assert parse_args(["-h"]) == :help
    assert parse_args(["-h", "anything", "whatever"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test 'return %{ location: "", language: "" } by not giving any arguments' do
    assert parse_args([]) == %{ language: "", location: "" }
  end

  test 'return %{ location: location, language: "" }, by giving only location' do
    assert parse_args(["--location", "Cyprus"]) == %{ location: "Cyprus", language: "" }
    assert parse_args(["-loc", "Amsterdam"]) == %{ location: "Amsterdam", language: ""}
  end

  test 'return %{ location: "", language: language }, by giving only language' do
    assert parse_args(["--language", "Python"]) == %{ location: "", language: "Python" }
    assert parse_args(["-lan", "Java"]) == %{ location: "", language: "Java" }
  end

  test "return %{ location: location, language: language }, by giving both location and language" do
    assert parse_args(["--location", "London", "--language", "Javascript"]) == %{ location: "London", language: "Javascript" }
  end

  test "return %{ location: location, language: language }, by giving both location and language in different order" do
    assert parse_args(["--language", "Javascript", "--location", "London"]) == %{ location: "London", language: "Javascript" }
  end
end
