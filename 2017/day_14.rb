# hash
class Day14
  class << self
    def calc(input)

      grid = []
      index = 0
      128.times do
        row_input = "#{input}-#{index}"
        lengths = create_length_string(row_input)
        final_hash = create_hash(lengths)

        grid << convert_hex_to_binary(final_hash)

        index += 1
      end

      puts count_used(grid)

      grid_of_arrays = convert_to_array_of_arrays(grid)

      puts count_regions(grid_of_arrays)
    end

    def count_used(grid)
      total = 0
      grid.each do |line|
        total += line.chars.select { |x| x == "1"}.count
      end
      total
    end

    def convert_to_array_of_arrays(grid)
      new_grid = []
      grid.each do |line|
        new_grid << line.chars
      end
      new_grid
    end

    # this is like the count islands interview question
    def count_regions(grid)
      island_count = 0
      grid.each_with_index do |line, line_index|
        line.each_with_index do |element, element_index|
          if element == "1"
            island_count += 1
            grid[line_index][element_index] = "x"
            travel_island(grid, line_index, element_index)

            # print_grid(grid)
            # puts ""
          end
        end
      end
      puts "island count: #{island_count}"
    end

    def print_grid(grid)
      grid.each do |line|
        puts line.inspect
      end
    end

    def travel_island(grid, line_index, element_index)
      # up
      if(line_index >= 1 && grid[line_index-1][element_index] == "1")
        grid[line_index-1][element_index] = "x"
        travel_island(grid, line_index-1, element_index)
      end

      # down
      if(line_index < (grid.count - 1) && grid[line_index+1][element_index] == "1")
        grid[line_index+1][element_index] = "x"
        travel_island(grid, line_index+1, element_index)
      end

      # left
      if(element_index >= 1 && grid[line_index][element_index-1] == "1")
        grid[line_index][element_index-1] = "x"
        travel_island(grid, line_index, element_index-1)
      end

      # right
      if(element_index < (grid[0].count - 1) && grid[line_index][element_index+1] == "1")
        grid[line_index][element_index + 1] = "x"
        travel_island(grid, line_index, element_index+1)
      end

    end

    def convert_hex_to_binary(hex_number)
      hex_number.hex.to_s(2).rjust(hex_number.size*4, '0')
    end

    def create_hash(lengths)
      list = Array(0..255)

      skip_size = 0
      index = 0
      64.times do
        lengths.each do |length|
          process_length(list, index, length)
          index = wrapped_index(list, index + length + skip_size)
          skip_size += 1
        end
      end

      list_to_hex(dense_hash(list))
    end

    def process_length(list, index, length)
      raise "length too long for list" if length > list.length

      start_index = index
      end_index = index + length - 1

      # puts "list: #{list.inspect} index: #{index}, length: #{length} start: #{start_index} end: #{wrapped_index(list, end_index)}"

      while(end_index > start_index)
        safe_start = wrapped_index(list, start_index)
        safe_end   = wrapped_index(list, end_index)
        temp = list[safe_start]
        list[safe_start] = list[safe_end]
        list[safe_end] = temp

        end_index -=1
        start_index +=1
      end
    end

    # returns the index within the list, even if it wraps
    def wrapped_index(list, index)
      index % list.length
    end

    # takes a list and does xor on 16 char blocks
    def dense_hash(list)
      return_list = []
      running_val = nil
      list.each_with_index do |val, index|

        if index % 16 == 0
          running_val = val
        else
          running_val = running_val ^ val
        end

        if index % 16 == 15
          return_list << running_val
        end
      end
      return_list
    end

    # converts list of numbers into hex string
    def list_to_hex(list)
      new_list = []
      list.each do |item|
        converted = item.ord.to_s(16)
        if converted.length == 1
          converted = "0#{converted}"
        end
        new_list << converted
      end
      new_list.join
    end

    def create_length_string(input)
      convert_to_ascii(input) + [17,31,73,47,23]
    end

    def convert_to_ascii(input)
      input.chars.map(&:ord)
    end
  end
end

input = "ljoxqyyw"
Day14.calc(input)
grid = [
    "1100",
    "0101",
    ]
grid = [
    "11010100",
    "01010101",
    "00001010",
    "10101101",
    "01101000",
]
# new_grid = Day14.convert_to_array_of_arrays(grid)
# puts new_grid.inspect
# Day14.count_regions(new_grid)

# puts Day10.xor_string([65,27,9,1,4,3,40,50,91,7,6,0,2,5,68,22,65,27,9,1,4,3,40,50,91,7,6,0,2,5,68,22])
# input = "1,2,3"
# puts Day10.create_length_string(input).inspect
# input = "187,254,0,81,169,219,1,190,19,102,255,56,46,32,2,216"

# Day10.calc(input)
