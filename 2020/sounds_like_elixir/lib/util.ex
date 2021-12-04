defmodule Util do
  def integers_from_file(filename) do
    filename
    |> file_lines
    |> Enum.map(&ensure_integer/1)
  end

  def file_lines_separated_by_blank_line(filename) do
    {:ok, contents} = File.read(filename)

    contents
    |> String.split("\n\n", trim: true)
  end

  def file_lines(filename) do
    {:ok, contents} = File.read(filename)

    contents
    |> String.split("\n", trim: true)
  end

  def ensure_integer(value) do
    if(is_integer(value)) do
      value
    else
      value
      |> String.to_integer
    end
  end

  def print(value, label) do
    IO.inspect value, label: label, charlists: :as_lists
  end

end
