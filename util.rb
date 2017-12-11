def create_array_from_spaces(input)
  commands = input.split("\s")
  commands.map!(&:to_i)
end

