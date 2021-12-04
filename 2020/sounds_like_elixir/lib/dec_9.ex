defmodule Dec9 do
  @filename "dec_9.txt"
  @preamble_length 25

  def perform do
    full_list = parse_file()

    error = get_error(full_list)
    print(error, "error")

    find_fix(full_list, error)
    |> final_sum
  end

  def final_sum(list) do
    Enum.max(list) + Enum.min(list)
  end


  def find_fix([], _target), do: {:not_found}
  def find_fix(list = [_head | tail], target) do
#    IO.inspect "LOOP"
    case(sum_contiguous(list, [], 0, target)) do
      false -> find_fix(tail, target)
      array -> print(array, "found array")
    end
  end

  def sum_contiguous([], _, _, _), do: false
  def sum_contiguous(processing_list = [head | tail], current_list, acc, target) do
#    print(processing_list, "processing_list")
#    print(current_list, "current_list")
#    print(acc, "acc")

    new_sum = head + acc
    new_list = Enum.concat(current_list, [head])
    cond do
      new_sum == target -> new_list
      new_sum > target -> false
      true -> sum_contiguous(tail, new_list, new_sum, target)
    end
  end

  def print(value, label) do
    IO.inspect value, label: label, charlists: :as_lists
  end

  def get_error(list) do
    {preamble, [head | _rest]} = split_list(list)
#    IO.inspect list, label: "full list"
#    IO.inspect preamble, label: "preamble"
#    IO.inspect temp, label: "rest"

    cond do
      follow_rules?(preamble, head) ->
        [_ | shift] = list
        get_error(shift)
      true -> head
    end
  end

  def follow_rules?([], _target), do: false
  def follow_rules?([head | tail], target) do
    cond do
      does_sum?(head, tail, target) -> true
      true -> follow_rules?(tail, target)
    end
  end

  def does_sum?([first | rest], target), do: does_sum?(first, rest, target)
  def does_sum?(_first, [], _target), do: false
  def does_sum?(first, [head | tail], target) do
    cond do
      first + head == target -> true
      true -> does_sum?(first, tail, target)
    end
  end

  def split_list(list) do
    preamble = Enum.slice(list, 0..(@preamble_length-1))
    rest = Enum.drop(list, @preamble_length)
    {preamble, rest}
  end

  def parse_file do
    Util.integers_from_file("input/#{@filename}")
  end
end
