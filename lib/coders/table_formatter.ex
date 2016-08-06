defmodule Coders.TableFormatter do

  @doc """
  `data` is a list of maps.
  `fields` is the list of field names (headers)
  Prints the table
  """
  def print_table(data, fields) do
    hash_to_list(data, fields)
    |> get_table(fields)
    |> IO.puts
  end

  @doc """
  Returns ``data`` as a list of lists
  """
  def hash_to_list(data, fields) do
    for user <- data do
      for field <- fields do
        Map.get(user, field)
      end
    end
  end

  def get_table(rows, fields) do
    TableRex.quick_render!(rows, fields)
  end
end

