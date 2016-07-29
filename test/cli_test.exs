defmodule CliTest do
  use ExUnit.Case
  import Coders.CLI, only: [parse_args: 1]

  test "return :help by option parsing with -h and --help options" do
    assert parse_args(["-h"]) == :help
    assert parse_args(["-h", "anything", "whatever"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "return :help by not givin any arguments" do
    assert parse_args([]) == :help
  end

  test "location and language are given, tuple is returned" do
    assert parse_args(["Cyprus", "Javascript"]) == { "Cyprus", "Javascript" }
  end

  test "only location is given, tuple is returned" do
    assert parse_args(["Cyprus"]) == { "Cyprus", "Python" }
  end
end
