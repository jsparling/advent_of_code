defmodule Dec3 do
  @tree "#"

  @slopes [[1,1], [3,1], [5,1], [7,1], [1,2]]

  def perform do
    list = load_file()

    process_slopes(@slopes, list)
    |> Enum.reduce(fn x, acc -> x * acc end)
  end

  def process_slopes([], _), do: []
  def process_slopes([[right, down] | rest], list) do
    number_trees = list
    |> smart_drop(down)
    |> traverse(0, right)

    [number_trees] ++ process_slopes(rest, list)
  end

  def smart_drop(list = [first | rest], drop) do
    if(drop == 1) do
      rest
    else
      Enum.drop_every(rest, drop)
    end
  end

  def traverse([], _, _), do: 0
  def traverse(list = [current | rest], current_index, right) do
    new_index = current_index + right

    tree_at_index(current, new_index) + traverse(rest, new_index, right)
  end

  def tree_at_index(row, index) do
    translated_index = rem(index, row_length(row))
    if(Enum.at(row, translated_index) == @tree) do
      1
    else
      0
    end
  end

  def row_length(row) do
    length(row)
  end

  def load_file do
    Util.file_lines("input/dec_3.txt")
    |> Enum.map(&String.codepoints/1)
  end



end
