require 'set'
class Day6

  class << self
    def calc(input)
      memory = create_array(input)
      puts memory.inspect

      val = loop(memory)

      puts val
      # puts previous_iterations.inspect
    end

    def loop(memory)
      length = memory.length
      previous_iterations = {0 => memory}

      count = 0

      while(true)
        memory = Array.new(memory)

        max_value = memory.max
        index_of_max = memory.find_index(max_value)
        index = index_of_max

        mem_to_dist = memory[index]
        memory[index] = 0
        index += 1

        mem_to_dist.times do
          if index >= length
            index = 0
          end

          memory[index] += 1
          index += 1
        end

        puts memory.inspect
        count += 1

        if(previous_iterations.value?(memory))
          previous_iterations.each do |key, val|
            if val == memory
              return count - key
            end
          end
        else
          previous_iterations[count] = memory
        end
      end
      puts previous_iterations.inspect

      count
    end

    def create_array(input)
      commands = input.split("\s")
      commands.map!(&:to_i)
    end
  end

end

test_input = "0 2 7 0"
input = "2	8	8	5	4	2	3	1	5	5	1	2	15	13	5	14"
Day6.calc(input)
