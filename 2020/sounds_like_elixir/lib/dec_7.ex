defmodule Dec7 do
  @filename "dec_7_test.txt"
  @bag "shiny gold"

  def perform do
    map = parse_file()
    |> Enum.map(&parse_line/1)
    |> create_map

    find_count([@bag],  map)
  end

  def find_count([parent], map) do
    children = map[parent]

    if(children == [:end]) do
      0
    else
      children
      |> Enum.reduce(0, fn [count | name], acc -> acc + count + (count * find_count(name,map)) end)
    end
  end

  def perform_old do
    map = parse_file()
    |> Enum.map(&parse_line/1)
    |> create_map

    Map.to_list(map)
    |> Enum.map(&find_holders(&1, map))
    |> Enum.count(fn x -> x  end)
  end

  def find_holders({_parent, [:end]}, _), do: false
  def find_holders({@bag, [:end]}, _), do: false
  def find_holders({_parent, children }, map) do
    Enum.map(children, fn x ->
      cond do
        x == @bag -> true
        true -> find_holders({x, map[x]}, map)
      end
    end)
    |> List.flatten
    |> Enum.any?
  end

  def create_map(list) do
    list
    |> Enum.reduce(%{}, fn [index, values], acc -> Map.put(acc, index, values) end)
  end

  def parse_line(line) do
    [index, rest] = parse_index(line)

    children = parse_rest(rest)
    |> Enum.map(&parse_part/1)

    [clean_string(index), children]
  end

  def parse_part("no other bags."), do: :end
  def parse_part(string) do
    [count | color] = string
    |> clean_string
    |> String.split([" "], trim: true)

    #return the numbers
    [Util.ensure_integer(count), Enum.join(color, " ") ]
#    Enum.join(color, " ")
  end

  def clean_string(string) do
    string
    |> String.replace(["bag", "bags", "."], "")
    |> String.trim
  end

  def parse_rest(rest) do
    rest
    |> String.split(",", trim: true)
    |> Enum.map(&String.trim/1)
  end

  def parse_index(line) do
    line
    |> String.split("contain", trim: true)
    |> Enum.map(&String.trim/1)
  end

  def parse_file do
    Util.file_lines("input/#{@filename}")
  end
end
