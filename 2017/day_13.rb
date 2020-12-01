
class Day13
  class << self
    def calc(input)
      list = parse_input(input)

      print_rows(list)

      # puts "severity #{cycle_list(list)}"

      delay = 0
      while(!cycle_list(list, delay))
        delay += 1
      end

      puts delay
    end

    def cycle_list(list, delay)
      # severity = 0
      list.each_with_index do |item, index|
        next if item.nil?

        cycle = (item.count - 2) * 2 + 2
        if ((index + delay) % cycle == 0)
          # puts "caught #{index} * #{item.count}"
          # severity += (index * item.count)
          return false
        end
      end
      true
      # severity
    end

    def max_depth(list)
      max = 0
      list.each do |item|
        next if item.nil?

        max = [item.count, max].max
      end
      max
    end

    def parse_input(input)
      list = []
      lines = input.split("\n")
      lines.each do |line|
        elements = line.split(":")
        index = elements[0].to_i
        depth = elements[1].to_i

        arr = Array.new(depth){ |i| " "}
        arr[0] = "S"
        list[index] = arr
      end

      list
    end

    def print_rows(list, row = 0, max_depth = max_depth(list))
      list.each do |item|
        if item.nil?
          if row == 0
            print " ... "
          else
            print "     "
          end
        elsif item.count > row
          print " [#{item[row]}] "
        else
          print "     "
        end
      end

      row += 1
      if row <= max_depth
        puts ""
        print_rows(list, row, max_depth)
      end
    end
  end


end

input = "0: 3
1: 2
4: 4
6: 4"

input = "0: 3
1: 2
2: 4
4: 4
6: 5
8: 6
10: 8
12: 8
14: 6
16: 6
18: 9
20: 8
22: 6
24: 10
26: 12
28: 8
30: 8
32: 14
34: 12
36: 8
38: 12
40: 12
42: 12
44: 12
46: 12
48: 14
50: 12
52: 12
54: 10
56: 14
58: 12
60: 14
62: 14
64: 14
66: 14
68: 14
70: 14
72: 14
74: 20
78: 14
80: 14
90: 17
96: 18"

Day13.calc(input)
