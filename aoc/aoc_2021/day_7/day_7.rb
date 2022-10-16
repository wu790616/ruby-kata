class Day7
  attr_accessor :data, :min, :max

  def initialize
    @data = File.readlines('day_7.txt', chomp: true).first.split(',').map(&:to_i)
    @min  = data.min
    @max  = data.max
  end

  def call
    puts "1: #{part1}, 2: #{part2}"
  end

  def part1
    (min..max).map do |value|
      data.sum { |num| (num - value).abs }
    end.min
  end

  def part2
    (min..max).map do |value|
      data.sum { |num| (1..(num - value).abs).sum }
    end.min
  end
end

Day7.new.call
