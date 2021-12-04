defmodule Dec11Optim do
  @filename "dec_11.txt"

  def perform do
    full_list = parse_file()

    iterate(full_list)
    |> count_occupied
  end

  def iterate(original) do
    next = original
    |> preprocess
    |> loop

    cond do
      Enum.join(original) == Enum.join(next) -> original
      true -> iterate(next)
    end
  end

  def loop(list, prev \\ nil)
  def loop([row, next | rest], prev) do
    [process_items(Enum.with_index(row), prev, next) | loop([next | rest], row)]
  end

  def loop([row], prev) do
    [process_items(Enum.with_index(row), prev, nil)]
  end

  def process_items([{current, col_index}, next_entry | rest], prev_row, next_row) do
    [do_the_work(current, prev_row, next_row, col_index) | process_items([next_entry | rest], prev_row, next_row)]
  end

  def process_items([{current, col_index}], prev_row, next_row) do
    [do_the_work(current, prev_row, next_row, col_index)]
  end

  def do_the_work(%{value: "."}, _, _, _), do: "."
  def do_the_work(%{value: value, neighbors: neighbors}, prev_row, next_row, col_index) do
    surrounding_seated = surround_count(neighbors, prev_row, next_row, col_index)

    sit_or_stand(value, surrounding_seated)
  end

  def surround_count(neighbors, prev_row, next_row, col_index) do
    %{seated: prev_row_seated} = value_at(prev_row, col_index)
    %{seated: next_row_seated} = value_at(next_row, col_index)
    prev_row_seated + next_row_seated + neighbors
  end

  def sit_or_stand("#", surrounding_seated) when surrounding_seated >= 4, do: "L"
  def sit_or_stand("#", _), do: "#"
  def sit_or_stand("L", surrounding_seated) when surrounding_seated == 0, do: "#"
  def sit_or_stand("L", _), do: "L"

  def value_at(nil, _), do: %{seated: 0}
  def value_at(row, col_index) do
    Enum.at(row, col_index)
  end

  def preprocess([]), do: []
  def preprocess([head | rest]) do
    [preprocess_row(head) | preprocess(rest)]
  end

  def preprocess_row(list, prev \\ nil)
  def preprocess_row([current, next | rest], prev) do
    [%{:value => current, :seated => count_seated(prev, current, next), :neighbors => count_seated(prev, nil, next)} | preprocess_row([next | rest], current)]
  end

  def preprocess_row([current], prev) do
    [%{:value => current, :seated => count_seated(prev, current, nil), :neighbors => count_seated(prev, nil, nil)}]
  end

  def count_seated(prev, current, next) do
    seated_count(prev) + seated_count(current) + seated_count(next)
  end

  def seated_count("#"), do: 1
  def seated_count(_), do: 0

  def count_occupied(list) do
    list
    |> List.flatten
    |> Enum.count(fn x -> x == "#" end)
  end

  def parse_file do
    Util.file_lines("input/#{@filename}")
    |> Enum.map(&parse_row/1)
  end

  def parse_row(row) do
    String.codepoints(row)
  end
end
