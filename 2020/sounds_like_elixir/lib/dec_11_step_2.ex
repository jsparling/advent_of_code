defmodule Dec11Step2 do
  @filename "dec_11.txt"
  @sit_count 5

  def perform do
    full_list = parse_file()

    loop(full_list)
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

#    Util.print(next, "iterate")

    cond do
      Enum.join(original) == Enum.join(next) -> original
      true -> loop(next)
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
      "#" -> stand_if_possible(0, row_index, col_index, full_list, :up_left)
      other -> other
    end
  end

  # nobody seated around you
  def sit_if_possible(row_index, col_index, full_list) do
    with false <- next_seated?(:up_left, row_index, col_index, full_list),
         false <- next_seated?(:up, row_index, col_index, full_list),
         false <- next_seated?(:up_right, row_index, col_index, full_list),
         false <- next_seated?(:left, row_index, col_index, full_list),
         false <- next_seated?(:right, row_index, col_index, full_list),
         false <- next_seated?(:down_left, row_index, col_index, full_list),
         false <- next_seated?(:down, row_index, col_index, full_list),
         false <- next_seated?(:down_right, row_index, col_index, full_list)
      do
#        IO.inspect "sit"
        "#"
      else
#        err -> IO.inspect "don't sit"
        err -> "L"
    end
  end

  def next_seated?(direction, row_index, col_index, full_list) do
    {row, col} = get_next_seat_coords(direction, row_index, col_index, full_list)
    seated?(row, col, full_list)
   end

  def get_next_seat_coords(direction, row_index, col_index, full_list) do
    {start_row, start_col} = new_coords(direction, row_index, col_index)
    case (get_value(start_row, start_col, full_list)) do
      "." -> get_next_seat_coords(direction, start_row, start_col, full_list)
      _ -> {start_row, start_col}
    end
  end

  def new_coords(direction, row_index, col_index) do
    case (direction) do
      :up_left -> {row_index - 1, col_index - 1}
      :up -> {row_index - 1, col_index}
      :up_right -> {row_index - 1, col_index + 1}
      :left -> {row_index, col_index - 1}
      :right -> {row_index, col_index + 1}
      :down_left -> {row_index + 1, col_index - 1}
      :down -> {row_index + 1, col_index}
      :down_right -> {row_index + 1, col_index + 1}
      _ -> false
    end
  end



  def stand_if_possible(current_count, _row_index, _col_index, _full_list, _) when current_count >= @sit_count, do: "L"
  def stand_if_possible(current_count, row_index, col_index, full_list, direction = :up_left) do
    {row, col} = get_next_seat_coords(direction, row_index, col_index, full_list)
    new_count = current_count + count_of_seated(row, col, full_list)
#    IO.inspect("direction: #{direction}, orig_row: #{row_index}, orig_col: #{col_index}, new row: #{row}, new col: #{col}, new_count: #{new_count}")
    stand_if_possible(new_count, row_index, col_index, full_list, :up)
  end

  def stand_if_possible(current_count, row_index, col_index, full_list, direction = :up) do
    {row, col} = get_next_seat_coords(direction, row_index, col_index, full_list)
    new_count = current_count + count_of_seated(row, col, full_list)
    stand_if_possible(new_count, row_index, col_index, full_list, :up_right)
  end

  def stand_if_possible(current_count, row_index, col_index, full_list, direction = :up_right) do
    {row, col} = get_next_seat_coords(direction, row_index, col_index,full_list)
    new_count = current_count + count_of_seated(row, col, full_list)
    stand_if_possible(new_count, row_index, col_index, full_list, :left)
  end

  def stand_if_possible(current_count, row_index, col_index, full_list, direction = :left) do
    {row, col} = get_next_seat_coords(direction, row_index, col_index,full_list)
    new_count = current_count + count_of_seated(row, col, full_list)
    stand_if_possible(new_count, row_index, col_index, full_list, :right)
  end

  def stand_if_possible(current_count, row_index, col_index, full_list, direction = :right) do
    {row, col} = get_next_seat_coords(direction, row_index, col_index,full_list)
    new_count = current_count + count_of_seated(row, col, full_list)
    stand_if_possible(new_count, row_index, col_index, full_list, :down_left)
  end

  def stand_if_possible(current_count, row_index, col_index, full_list, direction = :down_left) do
    {row, col} = get_next_seat_coords(direction, row_index, col_index,full_list)
    new_count = current_count + count_of_seated(row, col, full_list)
    stand_if_possible(new_count, row_index, col_index, full_list, :down)
  end

  def stand_if_possible(current_count, row_index, col_index, full_list, direction = :down) do
    {row, col} = get_next_seat_coords(direction, row_index, col_index,full_list)
    new_count = current_count + count_of_seated(row, col, full_list)
    stand_if_possible(new_count, row_index, col_index, full_list, :down_right)
  end

  def stand_if_possible(current_count, row_index, col_index, full_list, direction = :down_right) do
    {row, col} = get_next_seat_coords(direction, row_index, col_index,full_list)
    new_count = current_count + count_of_seated(row, col, full_list)
    if(new_count >= @sit_count) do
      "L"
    else
      "#"
    end
  end

  def count_of_seated(row_index, col_index, full_list) do

    if(seated?(row_index, col_index, full_list)) do
      1
    else
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

  def get_value(row_index, col_index, _full_list) when row_index < 0 or col_index < 0, do: nil
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
