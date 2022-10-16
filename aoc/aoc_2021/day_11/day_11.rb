require 'set'

class Day11
  attr_accessor :data, :oct_map

  def initialize
    @data    = File.readlines('day_11.txt', chomp: true).map { |line| line.split('').map(&:to_i) }
    @oct_map = {}
  end

  def call
    puts "1: #{part1}, 2: #{part2}"
  end

  def part1
    init_oct_map

    res = 100.times.each_with_object([]) do |_, memo|
      oct_map.transform_values! { |value| value + 1 }
      cal_flash

      memo << oct_map.count { |_, value| value.zero? }
    end

    res.sum
  end

  def part2
    init_oct_map

    1.step do |idx|
      oct_map.transform_values! { |value| value + 1 }
      cal_flash

      return idx if oct_map.values.all?(&:zero?)
    end
  end

  def init_oct_map
    data.each.with_index do |row, y|
      row.each.with_index do |value, x|
        oct_map.merge!([x, y] => value)
      end
    end
  end

  def adjacent_octopuses(octopus)
    x, y = octopus

    [
      [x - 1, y - 1], [x, y - 1], [x + 1, y - 1],
      [x - 1, y], [x + 1, y],
      [x - 1, y + 1], [x, y + 1], [x + 1, y + 1]
    ].reject { |oct| oct.any? { |n| n.negative? || n > 9 } }
  end

  def cal_flash
    flash_octs = oct_map.select { |_key, value| value >= 10 }

    return if flash_octs.empty?

    oct_map.merge!(flash_octs.transform_values! { |_| 0 })
    flash_octs.each do |oct, _|
      adjacent_octs = oct_map.select { |key, value| adjacent_octopuses(oct).include?(key) && value != 0 }
      oct_map.merge!(adjacent_octs.transform_values! { |value| value + 1 })
    end

    cal_flash
  end
end

Day11.new.call
