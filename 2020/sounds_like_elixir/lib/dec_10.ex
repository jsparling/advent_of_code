defmodule Dec10 do
  @filename "dec_10_test.txt"

  def perform do
    list = parse_file()



#    final = Enum.max(list)
    find_perm(Enum.reverse([0] ++ list), Enum.max(list), %{})
#    find_permutations(list, 0, [], final)
#    biggest_path = find_biggest_path(list, 0, [], final)
#    num_skipped = find_perm(list, 0, [], final)

#    :math.pow(2,num_skipped)
#    |> round

#    find_perm(list, biggest_path, 0)
  end

  def find_perm([], current, counts) do
    if(current == 0) do
      1
    else
      0
    end
  end

  def find_perm(list, current, counts) do
    case(list) do
      [head, two, three | tail] ->
        cond do
          in_range(three, current) ->
            IO.inspect "three in range, current: #{current}, [#{head}, #{two}, #{three}]"
            find_perm([two, three | tail], head, counts)
          in_range(two, current) ->
            IO.inspect "two in range, current: #{current}, [#{head}, #{two}]"
            find_perm([two, three | tail], head, counts)
          in_range(head, current) ->
            IO.inspect "one in range, current: #{current}, [#{head}]"
            find_perm([two, three | tail], head, counts)
          true -> 0
        end
      [head, two | tail] ->
        cond do
          in_range(two, current) ->
            IO.inspect "two in range, current: #{current}, [#{head}, #{two}]"
            find_perm([two | tail], head, counts)
          in_range(head, current) ->
            IO.inspect "one in range, current: #{current}, [#{head}]"
            find_perm([two | tail], head, counts)
          true -> 0
        end
      [head | tail] ->
        cond do
          in_range(head, current) ->
            IO.inspect "one in range, current: #{current}, [#{head}]"
            find_perm(tail, head, counts)
          true -> 0
        end
    end
  end

  def append_to_map(map, index, nil), do: Map.put(map, index, 1)
  def append_to_map(map, index, current_value), do: Map.put(map, index, current_value)


#
#  def find_perm([], current, current_list, final) do
#    if(current == final) do
#      Util.print(current_list, "final list")
#      1
#    else
#      Util.print(current_list, "non final list")
#      0
#    end
#  end
#
#  def find_perm(list, current, current_list, final) do
#    IO.inspect ""
#    Util.print(current, "current")
#    Util.print(list, "list")
#    case(list) do
#      [head, two, three | tail] ->
#        cond do
#          in_range(three, current) ->
#            IO.inspect "three in range, current: #{current}, [#{head}, #{two}, #{three}]"
#            num = find_perm([two, three | tail], head, current_list ++ [head], final)
#            num + num + num
#          in_range(two, current) ->
#            IO.inspect "two in range, current: #{current}, [#{head}, #{two}]"
#            num = find_perm([two, three | tail], head, current_list ++ [head], final)
#            num + num
#          in_range(head, current) ->
#            IO.inspect "one in range, current: #{current}, [#{head}]"
#            find_perm([two, three | tail], head, current_list ++ [head], final)
#          true -> 0
#        end
#      [head, two | tail] ->
#        cond do
#          in_range(two, current) ->
#            num = find_perm([two | tail], head, current_list ++ [head], final)
#            num + num
#          in_range(head, current) ->
#            find_perm([two | tail], head, current_list ++ [head], final)
#          true -> 0
#        end
#      [head | tail] ->
#        cond do
#          in_range(head, current) -> find_perm(tail, head, current_list ++ [head], final)
#          true -> 0
#        end
#    end
#  end

  def find_biggest_path([], current, current_list, final) do
    if(current == final) do
      Util.print(current_list, "final list")
      current_list
    else
      Util.print(current_list, "non final list")
      false
    end
  end

    def find_biggest_path(list, current, current_list, final) do
#    Util.print(list, "list")

    case(list) do
      [head, two, three | tail] ->
        cond do
          in_range(three, current) -> find_biggest_path(tail, three, current_list ++ [three], final)
          in_range(two, current) -> find_biggest_path([three | tail], two, current_list ++ [two], final)
          in_range(head, current) -> find_biggest_path([two, three | tail], head, current_list ++ [head], final)
          true -> 0
        end
      [head, two | tail] ->
        cond do
          in_range(two, current) -> find_biggest_path(tail, two, current_list ++ [two], final)
          in_range(head, current) -> find_biggest_path([two | tail], head, current_list ++ [head], final)
          true -> 0
        end
      [head | tail] ->
        cond do
          in_range(head, current) -> find_biggest_path(tail, head, current_list ++ [head], final)
          true -> 0
        end
    end
  end

  def find_biggest_path(list, current, current_list, final) do
#    Util.print(list, "list")

    case(list) do
      [head, two, three | tail] ->
        cond do
          in_range(three, current) -> find_biggest_path(tail, three, current_list ++ [three], final)
          in_range(two, current) -> find_biggest_path([three | tail], two, current_list ++ [two], final)
          in_range(head, current) -> find_biggest_path([two, three | tail], head, current_list ++ [head], final)
          true -> 0
        end
      [head, two | tail] ->
        cond do
          in_range(two, current) -> find_biggest_path(tail, two, current_list ++ [two], final)
          in_range(head, current) -> find_biggest_path([two | tail], head, current_list ++ [head], final)
          true -> 0
        end
      [head | tail] ->
        cond do
          in_range(head, current) -> find_biggest_path(tail, head, current_list ++ [head], final)
          true -> 0
        end
    end
  end

  def in_range(nil, _current), do: false
  def in_range(value, current), do: value - current <= 3



  def find_permutations([], current, current_list, final) do
    if(current == final) do
      1
    else
      0
    end
  end

  def find_permutations(list, current, current_list, final) do
    case(list) do
      [head, two, three | tail] ->
        call_if_range([two, three | tail], current, head, current_list, final) + call_if_range([three | tail], current, two, current_list, final) + call_if_range(tail, current, three, current_list, final)
      [head, two | tail] ->
        call_if_range([two| tail], current, head, current_list, final) + call_if_range(tail, current, two, current_list, final)
      [head | tail] ->
        call_if_range(tail, current, head, current_list, final)
    end
  end

  def call_if_range(new_list, current, next, current_list, final) do
    if(next - current > 3) do
      0
    else
      find_permutations(new_list, next, current_list ++ [current], final)
    end
  end



  def perform_old do
    {ones, threes} = parse_file()
    |> find_differences(0, 0, 0)
    |> plus_built_in
    |> IO.inspect

    ones * threes
  end

  def plus_built_in({ones, threes}), do: {ones, threes + 1}

  def find_differences([], _current, ones, threes), do: {ones, threes}
  def find_differences([head | tail], current, ones, threes) do
    diff = head - current
#    IO.inspect "find diff, current: #{current} head: #{head}"

    cond do
      diff == 0 ->
#        IO.inspect "diff: 0"
        find_differences(tail, head, ones, threes)
      diff == 1 ->
#        IO.inspect "diff: 1"
        find_differences(tail, head, ones + 1, threes)
      diff == 2 ->
#        IO.inspect "diff: 2"
        find_differences(tail, head, ones, threes)
      diff == 3 ->
#        IO.inspect "diff: 3"
        find_differences(tail, head, ones, threes + 1)
      true -> IO.inspect "not within three, current: #{current} head: #{head}"
    end
  end

  def parse_file do
    Util.integers_from_file("input/#{@filename}")
    |> Enum.sort
  end
end
