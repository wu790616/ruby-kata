require 'set'

class Day9
  attr_accessor :data, :max_y_idx, :max_x_idx, :low_points

  def initialize
    @data       = File.readlines('day_9.txt', chomp: true).map { |line| line.split('').map(&:to_i) }
    @max_y_idx  = data.size - 1
    @max_x_idx  = data.first.size - 1
    @low_points = []
  end

  def call
    init_low_points
    puts "1: #{part1}, 2: #{part2}"
  end

  def part1
    low_points.map(&:last).sum + low_points.size
  end

  def part2
    all_basin_size = low_points.map(&:first).map do |low_point|
      init_matched_set = Set[low_point]
      init_walked_set  = Set.new

      find_basin_size(init_matched_set, init_walked_set)
    end

    all_basin_size.max(3).inject(:*)
  end

  def init_low_points
    # Get all low_points with its place [x, y] and num value
    # [[[x1, y1] num1], [[x2, y2], num2], ......]
    data.each.with_index do |row, y|
      row.each.with_index do |num, x|
        around_nums = around_points([x, y]).map { |point| point_value(point) }
        sorted_nums = (around_nums << num).sort

        low_points << [[x, y], num] if sorted_nums.first == num && sorted_nums[1] != num
      end
    end
  end

  def point_value(point)
    data[point[1]][point[0]]
  end

  def around_points(point)
    x, y = point

    right_point = x == max_x_idx ? nil : [x + 1, y]
    left_point  = x.zero?        ? nil : [x - 1, y]
    up_point    = y.zero?        ? nil : [x, y - 1]
    down_point  = y == max_y_idx ? nil : [x, y + 1]

    [right_point, left_point, up_point, down_point].compact.to_set
  end

  def find_basin_size(matched_set, walked_set)
    # return matched_set size when all points in matched_set walked
    return matched_set.size if walked_set.superset?(matched_set)

    (matched_set - walked_set).each do |point|
      matched_set.merge(matched_around_points(point))
      walked_set.add(point)
    end

    find_basin_size(matched_set, walked_set)
  end

  def matched_around_points(point)
    res = around_points(point).each_with_object([]) do |round_point, memo|
      memo << round_point if point_value(round_point) < 9
    end

    res.to_set
  end
end

Day9.new.call
