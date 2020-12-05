defmodule Dec4 do

#  @fields ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

  def perform do
    file_lines()
    |> Enum.map(&parse_line/1)
    |> Enum.map(&clean_list/1)
    |> Enum.count(fn x -> passport_valid(x) end)
  end

  def clean_list(line) do
    Enum.map(line, fn x -> String.split(x, ":") end)
  end

  def passport_valid(passport) do
    valid_fields = passport
    |> Enum.count(fn [k,v] -> count_valid(k,v) end)

    valid_fields == 7
  end

  def count_valid("", _value), do: false
  def count_valid("cid", _value), do: false
  def count_valid("byr", value) do
    between(Util.ensure_integer(value), 1920, 2002)
  end

  def count_valid("iyr", value) do
    between(Util.ensure_integer(value), 2010, 2020)
  end

  def count_valid("eyr", value) do
    between(Util.ensure_integer(value), 2020, 2030)
  end

  def count_valid("hgt", value) do
    case(String.reverse(value)) do
      "mc" <> val -> between(Util.ensure_integer(String.reverse(val)), 150, 193)
      "ni" <> val -> between(Util.ensure_integer(String.reverse(val)), 59, 76)
      _ -> false
    end
  end

  def count_valid("hcl", value) do
    String.match?(value, ~r/^#[a-fA-F0-9]{6}$/)
  end

  def count_valid("ecl", value) when value in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"], do: true
  def count_valid("ecl", _value), do: false

  def count_valid("pid", value) do
    String.match?(value, ~r/^[0-9]{9}$/)
  end

  def between(value, min, max) do
    min <= value and value <= max
  end

  def parse_line(line) do
    line
    |> String.split([" ", "\n"], trim: true)
  end

  def file_lines do
    filename = "input/dec_4.txt"
    {:ok, contents} = File.read(filename)

    contents
    |> String.split("\n\n", trim: true)
  end


#  def remove_cid(line) do
#    Enum.reject(line, fn x -> x == "cid" end)
#  end

#  def remove_blank(line) do
#    Enum.reject(line, fn x -> x == [""] end)
#  end


end
