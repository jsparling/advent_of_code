defmodule Dec11 do
  @filename "dec_11.txt"

  def perform do
    full_list = parse_file()

    loop(full_list)
    |> count_occupied
  end

  def perform_optimized do
    full_list = parse_file()

    loop_optimized(full_list)
    |> count_occupied
  end

  def count_occupied(list) do
    list
    |> List.flatten
    |> Enum.count(fn x -> x == "#" end)
  end

  def loop(original) do
    next = original
            |> Enum.with_index
            |> Enum.map(&process_row(&1, original))

    cond do
      Enum.join(original) == Enum.join(next) -> original
      true -> loop(next)
    end
  end

  def loop_optimized(original) do
    next = original
            |> Enum.with_index
            |> Enum.map(&process_row_optimized(&1, original))

    cond do
      Enum.join(original) == Enum.join(next) -> original
      true -> loop_optimized(next)
    end
  end


  def process_row({row, row_index}, full_list) do
    row
    |> Enum.with_index
    |> Enum.map(&process_item(&1, row_index, full_list))
  end

  def process_item({value, col_index}, row_index, full_list) do
    case value do
      "L" -> sit_if_possible(row_index, col_index, full_list)
      "#" -> stand_if_possible(row_index, col_index, full_list)
      other -> other
    end
  end

  def process_row_optimized({row, row_index}, full_list) do
    row
    |> Enum.with_index
    |> Enum.map(&process_item_optimized(&1, row_index, full_list))
  end

  def process_item_optimized({value, col_index}, row_index, full_list) do
    case value do
      "L" -> sit_if_possible(row_index, col_index, full_list)
      "#" -> stand_if_possible_optimized(0, row_index, col_index, full_list, 0)
      other -> other
    end
  end

  # nobody seated around you
  def sit_if_possible(row_index, col_index, full_list) do
    with false <- seated?(row_index - 1, col_index - 1, full_list),
         false <- seated?(row_index - 1, col_index, full_list),
         false <- seated?(row_index - 1, col_index + 1, full_list),
         false <- seated?(row_index, col_index - 1, full_list),
         false <- seated?(row_index, col_index + 1, full_list),
         false <- seated?(row_index + 1, col_index - 1, full_list),
         false <- seated?(row_index + 1, col_index, full_list),
         false <- seated?(row_index + 1, col_index + 1, full_list)
      do
#        IO.inspect "sit"
        "#"
      else
#        err -> IO.inspect "don't sit"
        err -> "L"
    end
  end

#  # nobody seated around you
  def stand_if_possible(row_index, col_index, full_list) do
    total = count_of_seated(row_index - 1, col_index - 1, full_list) + count_of_seated(row_index - 1, col_index, full_list) + count_of_seated(row_index - 1, col_index + 1, full_list) + count_of_seated(row_index, col_index - 1, full_list) + count_of_seated(row_index, col_index + 1, full_list) + count_of_seated(row_index + 1, col_index - 1, full_list) + count_of_seated(row_index + 1, col_index, full_list) + count_of_seated(row_index + 1, col_index + 1, full_list)

    if(total >= 4) do
#      IO.inspect("stand up")
      "L"
    else
      "#"
    end
  end

  def stand_if_possible_optimized(current_count, _row_index, _col_index, _full_list, _) when current_count >= 4, do: "L"
  def stand_if_possible_optimized(current_count, row_index, col_index, full_list, 0) do
    new_count = current_count + count_of_seated(row_index - 1, col_index - 1, full_list)
    stand_if_possible_optimized(new_count, row_index, col_index, full_list, 1)
  end

  def stand_if_possible_optimized(current_count, row_index, col_index, full_list, 1) do
    new_count = current_count + count_of_seated(row_index - 1, col_index, full_list)
    stand_if_possible_optimized(new_count, row_index, col_index, full_list, 2)
  end

  def stand_if_possible_optimized(current_count, row_index, col_index, full_list, 2) do
    new_count = current_count + count_of_seated(row_index - 1, col_index + 1, full_list)
    stand_if_possible_optimized(new_count, row_index, col_index, full_list, 3)
  end

  def stand_if_possible_optimized(current_count, row_index, col_index, full_list, 3) do
    new_count = current_count + count_of_seated(row_index, col_index - 1, full_list)
    stand_if_possible_optimized(new_count, row_index, col_index, full_list, 4)
  end

  def stand_if_possible_optimized(current_count, row_index, col_index, full_list, 4) do
    new_count = current_count + count_of_seated(row_index, col_index + 1, full_list)
    stand_if_possible_optimized(new_count, row_index, col_index, full_list, 5)
  end

  def stand_if_possible_optimized(current_count, row_index, col_index, full_list, 5) do
    new_count = current_count + count_of_seated(row_index + 1, col_index - 1, full_list)
    stand_if_possible_optimized(new_count, row_index, col_index, full_list, 6)
  end

  def stand_if_possible_optimized(current_count, row_index, col_index, full_list, 6) do
    new_count = current_count + count_of_seated(row_index + 1, col_index, full_list)
    stand_if_possible_optimized(new_count, row_index, col_index, full_list, 7)
  end

  def stand_if_possible_optimized(current_count, row_index, col_index, full_list, 7) do
    new_count = current_count + count_of_seated(row_index + 1, col_index + 1, full_list)
    if(new_count >= 4) do
      "L"
    else
      "#"
    end
  end



  def count_of_seated(row_index, col_index, full_list) do

    if(seated?(row_index, col_index, full_list)) do
#      IO.inspect("COS YES --- row: #{row_index}, col: #{col_index}")
      1
    else
#      IO.inspect("COS NO  --- row: #{row_index}, col: #{col_index}")
      0
    end
  end


  def seated?(row_index, col_index, full_list) do
    case(get_value(row_index, col_index, full_list)) do
      nil -> false
      "#" -> true
      "." -> false
      "L" -> false
      _ -> IO.inspect "unknown value"
    end
  end

  def get_value(row_index, col_index, full_list) when row_index < 0 or col_index < 0, do: nil
  def get_value(row_index, col_index, full_list) do
    Enum.at(full_list, row_index)
    |> item_at_col_index(col_index)
  end

  def item_at_col_index(nil, _), do: nil
  def item_at_col_index(row, col_index), do: Enum.at(row, col_index)

  def parse_file do
    Util.file_lines("input/#{@filename}")
    |> Enum.map(&parse_row/1)
  end

  def parse_row(row) do
    String.codepoints(row)
  end
end
