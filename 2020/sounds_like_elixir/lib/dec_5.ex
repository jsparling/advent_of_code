defmodule Dec5 do
  # Binary Space Partitioning

  @filename "dec_5.txt"
  @max_row 127
  @max_col 7

  def perform do
    id_list()
    |> find_missing_id
  end

  def id_list do
    parse_file()
    |> Enum.map(&process_seat/1)
    |> Enum.sort
  end

  def find_missing_id([head | tail]), do: find_missing_id(tail, head)
  def find_missing_id([], _), do: IO.inspect "shouldn't get here"
  def find_missing_id([head | tail], nil), do: find_missing_id(tail, head)
  def find_missing_id([head | tail], previous_value) do
    cond do
      previous_value + 1 == head ->
        find_missing_id(tail, head)
      true ->
        previous_value + 1
    end
  end

  def process_seat(<<row::binary-size(7), col::binary-size(3)>>) do
    row_number = search(String.codepoints(row), [0, @max_row])
    col_number = search(String.codepoints(col), [0, @max_col])

    seat_id = row_number * 8 + col_number

#    IO.inspect "row: #{row_number}, col: #{col_number}, id: #{seat_id}"
    seat_id
  end

  def search(_, [min, max]) when min == max, do: min
  def search([head | rest], [min, max]) do
    new_range = process(head, split_range(min, max))

    search(rest, new_range)
  end

  def process("F", [front, _]), do: front
  def process("L", [left, _]), do: left
  def process("B", [_, back]), do: back
  def process("R", [_, right]), do: right
  # these work too, but i think clearer with 4 patterns
  #  def process(val, [low, _]) when val in ["F","L"], do: low
  #  def process(val, [_, high]) when val in ["B","R"], do: high

  def split_range(min, max) do
    midpoint = floor((max - min) / 2) + min

    [[min, midpoint], [midpoint+1, max]]
  end

  def parse_file do
    Util.file_lines("input/#{@filename}")
  end
end
