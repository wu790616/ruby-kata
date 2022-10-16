require 'set'

class Day8
  attr_accessor :data, :output_value, :uniq_pattern

  def initialize
    @data         = File.readlines('day_8.txt', chomp: true).map { |item| item.split(' | ') }
    @uniq_pattern = data.map { |item| item.first.split(' ').map { |value| value.split('').to_set } }
    @output_value = data.map { |item| item.last.split(' ').map { |value| value.split('').to_set } }
  end

  def call
    puts "1: #{part1}, 2: #{part2}"
  end

  def part1
    output_value.flatten.select do |value|
      [2, 3, 4, 7].include?(value.size)
    end.size
  end

  def part2
    uniq_pattern.map.with_index do |pattern, idx|
      mapping = find_mapping(pattern)

      output_value[idx].map { |value| mapping.key(value) }.join.to_i
    end.sum
  end

  def find_mapping(pattern)
    res_map = {
      1 => pattern.find { |set| set.size == 2 },
      4 => pattern.find { |set| set.size == 4 },
      7 => pattern.find { |set| set.size == 3 },
      8 => pattern.find { |set| set.size == 7 }
    }

    pattern.select { |set| set.size == 6 }.each do |value|
      if value.superset?(res_map[4])
        res_map[9] = value
      elsif !value.superset?(res_map[1])
        res_map[6] = value
      else
        res_map[0] = value
      end
    end

    pattern.select { |set| set.size == 5 }.each do |value|
      if value.superset?(res_map[1])
        res_map[3] = value
      elsif res_map[6].superset?(value)
        res_map[5] = value
      else
        res_map[2] = value
      end
    end

    res_map
  end
end

Day8.new.call
