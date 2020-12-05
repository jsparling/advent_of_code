defmodule Template do
  @filename "dec_5_test.txt"

  def perform do
    parse_file()
  end

  def parse_file do
    Util.file_lines("input/#{@filename}")
  end
end
