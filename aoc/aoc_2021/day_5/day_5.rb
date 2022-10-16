class Day5
  attr_accessor :data, :map_data, :line_data, :diagonal_data

  def initialize
    @data     = File.readlines('day_5.txt', chomp: true)
    @map_data = data.map { |data| data.split(' -> ') }.map do |vent|
      x1, y1 = vent.first.split(',').map(&:to_i)
      x2, y2 = vent.last.split(',').map(&:to_i)

      { x1: x1, y1: y1, x2: x2, y2: y2 }
    end
    @line_data     = map_data.reject { |data| data[:x1] != data[:x2] && data[:y1] != data[:y2] }
    @diagonal_data = map_data - line_data
  end

  def call
    part1_res = calculate_point(part1)
    part2_res = calculate_point(part2)

    puts "1: #{part1_res}, 2: #{part2_res}"
  end

  def part1
    line_data.each_with_object({}) do |line, memo|
      x_diff = line[:x2] - line[:x1]
      y_diff = line[:y2] - line[:y1]

      if x_diff != 0
        (0..x_diff.abs).each do |n|
          x_value = x_diff.positive? ? line[:x1] + n : line[:x1] - n
          add_point(x_value, line[:y1], memo)
        end
      else
        (0..y_diff.abs).each do |n|
          y_value = y_diff.positive? ? line[:y1] + n : line[:y1] - n
          add_point(line[:x1], y_value, memo)
        end
      end
    end
  end

  def part2
    diagonal_data.each_with_object(part1) do |line, memo|
      x_diff = line[:x2] - line[:x1]
      y_diff = line[:y2] - line[:y1]

      (0..x_diff.abs).each do |n|
        x_value = x_diff.positive? ? line[:x1] + n : line[:x1] - n
        y_value = y_diff.positive? ? line[:y1] + n : line[:y1] - n

        add_point(x_value, y_value, memo)
      end
    end
  end

  def add_point(x_value, y_value, memo)
    memo[x_value] ||= {}
    memo[x_value][y_value] = memo[x_value][y_value].to_i + 1
  end

  def calculate_point(point_map)
    point_map.values.sum do |x_line|
      x_line.values.select { |value| value >= 2 }.size
    end
  end
end

Day5.new.call
