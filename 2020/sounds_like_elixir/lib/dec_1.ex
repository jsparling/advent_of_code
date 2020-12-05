defmodule Dec1 do
  def perform do
    numbers()
    |> init_find_match
  end

  def perform_optimized do
    {small, big} = sort_numbers(numbers())

    init_find_optimized(small, big)
  end

  def perform_step_2_old do
    iterate_old_first(numbers(), numbers())
  end

  def perform_step_2 do
    numbers()
    |> start
  end

  def iterate_old_first(full_list, [first | all_but_first]) do
    case(iterate_old_second(first, full_list))  do
      {:not_found} -> iterate_old_first(full_list, all_but_first)
      other -> other
    end
  end

  def iterate_old_second(_, []), do: {:not_found}
  def iterate_old_second(first, full_list = [second | tail]) do
    case(iterate_old_third(first, second, full_list))  do
      {:not_found} -> iterate_old_second(first, tail)
      other -> other
    end
  end

  def iterate_old_third(_, _, []), do: {:not_found}
  def iterate_old_third(first, second, [third | tail]) do
    cond do
      third == first  -> iterate_old_third(first, second, tail)
      third == second -> iterate_old_third(first, second, tail)
      (first + second + third) == 2020 -> {:found, first, second, third, first * second * third}
      true -> iterate_old_third(first, second, tail)
    end
  end

  def start(list) do
    iterate_first(list, list)
  end

  def iterate_first(full_list, [first | all_but_first]) do
    case(iterate_second(first, full_list))  do
      {:not_found} -> iterate_first(full_list, all_but_first)
      other -> other
    end
  end

  def iterate_second(_, []), do: {:not_found}
  def iterate_second(first, full_list = [second | tail]) do
    if(first == second ) do
      iterate_second(first, tail)
    else
      case(iterate_third(first, second, full_list))  do
        {:not_found} -> iterate_second(first, tail)
        other -> other
      end
    end
  end

  def iterate_third(_, _, []), do: {:not_found}
  def iterate_third(first, second, [third | tail]) do
    cond do
      third == first  -> iterate_third(first, second, tail)
      third == second -> iterate_third(first, second, tail)
      (first + second + third) == 2020 -> {:found, first, second, third, first * second * third}
      true -> iterate_third(first, second, tail)
    end
  end

  def init_find_optimized(small = [small_head | small_tail], big = [big_head | big_tail], count \\ 0) do
    sum = small_head + big_head

    cond do
      sum == 2020 -> {:found, small_head, big_head, small_head * big_head}
      sum < 2020 -> init_find_optimized(small_tail, big, count+1)
      sum > 2020 -> init_find_optimized(small, big_tail, count+1)
    end
  end

  def init_find_match([orig | tail], count \\ 0) do
    case(find_match(orig, tail)) do
      {:not_found} -> init_find_match(tail, count + 1)
      {:found, orig, match} ->  {:found, orig, match, orig * match}
      other -> other
    end
  end

  def find_match(_orig, []), do: {:not_found}
  def find_match(orig, [head | tail]) do
    if((orig + head) == 2020) do
      {:found, orig, head}
    else
      find_match(orig, tail)
    end
  end

  def sort_numbers(numbers) do
    small = Enum.sort(numbers)
    {small, Enum.reverse(small)}
  end

  def numbers do
    Util.integers_from_file("input/dec_1.txt")
  end

end
