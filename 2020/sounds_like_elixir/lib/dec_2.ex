defmodule Dec2 do
  def perform_2 do
    Util.file_lines("input/dec_2.txt")
    |> Enum.map(&parse_line/1)
    |> Enum.count(fn x -> is_valid_2(x) end)
  end

  def is_valid_2([pos_1, pos_2, letter, password]) do
    list = String.codepoints(password)

    cond do
      value_at_position(letter, list, pos_1) and value_at_position(letter, list, pos_2) -> false
      value_at_position(letter, list, pos_1) or value_at_position(letter, list, pos_2) -> true
      true -> false
    end
  end

  def value_at_position(letter, list, index) do
    Enum.at(list, index-1) == letter
  end

  def perform do
    Util.file_lines("input/dec_2.txt")
    |> Enum.map(&parse_line/1)
    |> Enum.count(fn x -> is_valid(x) end)
  end

  def is_valid([min, max, letter, password]) do
    count_letter(letter, password)
    |> in_range(min, max)
  end

  def in_range(count, min, max) when min <= count and count <= max, do: true
  def in_range(_, _, _), do: false

  def count_letter(letter, password) do
    password
    |> String.codepoints
    |> Enum.count(fn x -> x == letter end)
  end


  def parse_line(line) do
    [range, letter, _, password] = String.split(line, [" ", ":"])

    [min,max] = String.split(range, "-")
    |> Enum.map(&Util.ensure_integer/1)

    [min, max, letter, password]
  end
end
