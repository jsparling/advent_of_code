
class Day10
  class << self
    def calc(input)
      # lengths = create_array_from_spaces(input)

      lengths = create_length_string(input)

      list = Array(0..255)
      puts list.inspect

      skip_size = 0
      index = 0
      64.times do
        lengths.each do |length|
          puts "before: #{list.inspect}"
          process_length(list, index, length)
          index = wrapped_index(list, index + length + skip_size)
          skip_size += 1
          puts "after: #{list.inspect}"
          puts ""
        end
      end

      final_hash = list_to_hex(dense_hash(list))

      # puts list[0] * list[1]

      puts final_hash
    end

    def process_length(list, index, length)
      raise "length too long for list" if length > list.length

      start_index = index
      end_index = index + length - 1

      puts "list: #{list.inspect} index: #{index}, length: #{length} start: #{start_index} end: #{wrapped_index(list, end_index)}"

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
        puts "index: #{index}, val: #{val}"

        if index % 16 == 0
          puts "start new group"
          running_val = val
        else
          running_val = running_val ^ val
        end

        if index % 16 == 15
          puts "save this one off"
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

    def create_array_from_spaces(input)
      commands = input.split(",")
      commands.map!(&:to_i)
    end
  end
end

input = ""
input = "AoC 2017"
input = "1,2,3"
input = "1,2,4"
input = "187,254,0,81,169,219,1,190,19,102,255,56,46,32,2,216"

Day10.calc(input)

# puts Day10.xor_string([65,27,9,1,4,3,40,50,91,7,6,0,2,5,68,22,65,27,9,1,4,3,40,50,91,7,6,0,2,5,68,22])
# input = "1,2,3"
# puts Day10.create_length_string(input).inspect
# input = "187,254,0,81,169,219,1,190,19,102,255,56,46,32,2,216"

# Day10.calc(input)
