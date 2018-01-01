class Day3
  class << self
    def calc(input)

      current_number = 1
      matrix = [[1]]

      current_coords = Coords.new(x: 0, y: 0)
      max_coords = Coords.new(x: 0, y: 0)

      right = false
      top = false
      left = false
      bottom = false

      while(current_number <= input)
        if(max_coords.equals?(current_coords))
          # puts "expand matrix"
          matrix = expand_matrix(matrix)

          max_coords.x = matrix[0].length - 1
          max_coords.y = matrix.length - 1

          current_coords.x = current_coords.x+2
          current_coords.y = current_coords.y+1

          right = true
        elsif(right)
          current_coords.y = current_coords.y-1
          if(current_coords.y == 0)
            right = false
            top = true
          end
        elsif(top)
          current_coords.x = current_coords.x-1
          if(current_coords.x == 0)
            top = false
            left = true
          end
        elsif(left)
          current_coords.y = current_coords.y+1
          if(current_coords.y == max_coords.y)
            left = false
            bottom = true
          end
        elsif(bottom)
          current_coords.x = current_coords.x+1
          if(current_coords.x == max_coords.x)
            bottom = false
          end
        end

        current_number = calculate_next_number(matrix, current_coords, current_number)
        matrix[current_coords.y][current_coords.x] = current_number
      end

      print_matrix(matrix)

      puts current_coords
      center_coords = Coords.new(x: max_coords.x / 2, y: max_coords.y/2)
      puts center_coords

      puts manhattan_distance(center_coords, current_coords)

      puts "part two: #{current_number}"
    end

    def manhattan_distance(target, origin)
      sum =  (target.x - origin.x).abs
      sum += (target.y - origin.y).abs
      sum
    end

    def calculate_next_number(matrix, coords, current_number)
      # TL
      current_number  = value_at(x_trans: -1, y_trans: -1, matrix: matrix, coords: coords)
      current_number += value_at(x_trans:  0, y_trans: -1, matrix: matrix, coords: coords)
      current_number += value_at(x_trans:  1, y_trans: -1, matrix: matrix, coords: coords)
      current_number += value_at(x_trans: -1, y_trans:  0, matrix: matrix, coords: coords)
      # current_number += value_at(x_trans:  0, y_trans:  0, matrix: matrix, coords: coords)
      current_number += value_at(x_trans:  1, y_trans:  0, matrix: matrix, coords: coords)
      current_number += value_at(x_trans: -1, y_trans:  1, matrix: matrix, coords: coords)
      current_number += value_at(x_trans:  0, y_trans:  1, matrix: matrix, coords: coords)
      current_number += value_at(x_trans:  1, y_trans:  1, matrix: matrix, coords: coords)

      current_number
    end

    def value_at(matrix:, coords: , x_trans: , y_trans: )

      new_x = coords.x + x_trans
      new_y = coords.y + y_trans

      puts "orig: #{coords.to_s} new: x: #{new_x} y: #{new_y}"
      if(new_x >= 0 && new_x <= (matrix[0].length - 1) && new_y >= 0 && new_y <= (matrix.length - 1))
        return matrix[new_y][new_x].to_i
      end

      0
    end


    def expand_matrix(matrix)
      size = matrix.length + 2
      blank_row = Array.new(size)

      new_matrix = [blank_row]

      matrix.each do |row|
        temp = Array.new(row)
        temp.unshift(nil) << nil
        new_matrix << temp
      end
      new_matrix << Array.new(blank_row)
    end

    def print_matrix(matrix)
      matrix.each do |line|
        puts line.inspect
      end
    end

  end
end

class Coords
  attr_accessor :x, :y

  def initialize(x: , y:)
    @x = x
    @y = y
  end

  def equals?(coords)
    coords.x == x && coords.y == y
  end

  def to_s
    "x: #{x}, y: #{y}"
  end
end

# Day3.calc(1)
# Day3.calc(12)
Day3.calc(312051)
# Day3.calc(1024)
