def create_array_from_spaces(input)
  commands = input.split("\s")
  commands.map!(&:to_i)
end

# starting point

class Day8
  class << self
    def calc(input)
      puts input
    end
  end
end

input = ""

Day8.calc(input)
