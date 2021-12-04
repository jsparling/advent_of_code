defmodule Dec6 do
  @filename "dec_6.txt"

  def perform do
    parse_file()
    |> Enum.map(&parse_group/1)
    |> Enum.map(&count_total_for_group(&1, length(&1)))
    |> Enum.sum
  end

  def count_total_for_group(a \\ %{}, b, c)
  def count_total_for_group(unique_letters, [], number_in_group) do
    Enum.count(Map.to_list(unique_letters), fn {key, value} -> value == number_in_group end)
  end

  def count_total_for_group(unique_letters, temp = [head | tail], number_in_group) do
    String.codepoints(head)
    |> Enum.reduce(unique_letters, fn x, acc -> add_to_list(acc, x) end)
    |> count_total_for_group(tail, number_in_group)
  end

  def add_to_list(current_list, new_value) do
    Map.update(current_list, new_value, 1, fn existing_value -> existing_value + 1 end)
  end

  def perform_old do
    parse_file()
    |> Enum.map(&parse_group/1)
    |> Enum.map(&count_unique_for_group/1)
    |> Enum.sum
  end

  def count_unique_for_group(a \\ %{}, b)
  def count_unique_for_group(unique_letters, []), do: length(Map.keys(unique_letters))
  def count_unique_for_group(unique_letters, [head | tail]) do
    String.codepoints(head)
    |> Enum.reduce(unique_letters, fn x, acc -> Map.put(acc, x, true) end)
    |> count_unique_for_group(tail)
  end

  def parse_group(group) do
    String.split(group, "\n", trim: true)
  end

  def parse_file do
    Util.file_lines_separated_by_blank_line("input/#{@filename}")
  end
end
