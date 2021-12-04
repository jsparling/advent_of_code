defmodule Dec8 do
  @filename "dec_8.txt"

  def perform do
    list = parse_file()
    |> Enum.map(&parse_line/1)
    |> Enum.with_index

#    run_operations(0, list, 0, %{})
    find_error(list, list, 0)
  end

#  def run(index, current_op, list, acc, visited ) when visited[index], do: acc

  def find_error(current_list, original_list, index) do
#    IO.inspect current_list, label: "current_list"
#    IO.inspect original_list, label: "original_list"
    IO.inspect index, label: "index"

    case(run_operations(0, current_list, 0, %{})) do
      {:loop, _acc} ->
        {new_list, new_index} = swap(original_list, index)
        find_error(new_list, original_list, new_index)
      acc -> acc
    end
  end

  def swap(list, index) do
    case(Enum.at(list, index)) do
      {%{opp: "nop", count: count, sign: sign}, item_index} ->
        new_list = replace_item(list, index, {%{opp: "jmp", count: count, sign: sign}, item_index})
        {new_list, index+1}
      {%{opp: "jmp", count: count, sign: sign}, item_index} ->
        new_list = replace_item(list, index, {%{opp: "nop", count: count, sign: sign}, item_index})
        {new_list, index+1}
      _ -> swap(list, index + 1)
    end
  end

  def replace_item(list, index, new_item) do
    case(Enum.split(list, index)) do
      {keep, [drop | rest]} -> combine(keep, new_item, rest)
      {temp, []} ->
        temp
        |> Enum.reverse
        |> Enum.drop(1)
        |> Enum.reverse
        |> combine(new_item, [])
    end
  end

  def combine(left, middle, right) do
    left
    |> Enum.concat([middle])
    |> Enum.concat(right)
  end


  def run_operations(index, list, acc, visited) do
    if(visited[index]) do
      {:loop, acc}
    else
      updated_visited = Map.put(visited, index, true)
      new_acc = case(Enum.at(list, index)) do
        {%{opp: "nop"}, index} -> run_operations(index + 1, list, acc, updated_visited)
        {%{opp: "acc", count: count, sign: "+"}, index} -> run_operations(index + 1, list, acc + count, updated_visited)
        {%{opp: "acc", count: count, sign: "-"}, index} -> run_operations(index + 1, list, acc - count, updated_visited)
        {%{opp: "jmp", count: count, sign: "+"}, index} -> run_operations(index + count, list, acc, updated_visited)
        {%{opp: "jmp", count: count, sign: "-"}, index} -> run_operations(index - count, list, acc, updated_visited)
        nil -> acc
      end

      new_acc
    end
  end

  def parse_line(<<opp::binary-size(3), _::binary-size(1), sign::binary-size(1), count::binary>>) do
    %{opp: opp, sign: sign, count: Util.ensure_integer(count)}
  end

  def parse_file do
    Util.file_lines("input/#{@filename}")
  end
end
