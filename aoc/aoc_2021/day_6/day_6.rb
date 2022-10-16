class Day6
  attr_accessor :data

  def initialize
    @data = File.readlines('day_6.txt', chomp: true).first.split(',').map(&:to_i)
  end

  def call
    part1_res = count_fish(80)
    part2_res = count_fish(256)

    puts "1: #{part1_res}, 2: #{part2_res}"
  end

  def count_fish(day)
    fish_map = 8.downto(0).each_with_object({}) do |num, memo|
      memo[num] = data.count(num)
    end

    day.times do
      memo_map = fish_map.dup

      (0..8).each do |num|
        fish_map[num] = case num
                        when 8 then memo_map[0]
                        when 6 then memo_map[0] + memo_map[7]
                        else memo_map[num + 1]
                        end
      end
    end

    fish_map.values.sum
  end
end

Day6.new.call
