class Day1
  attr_accessor :data

  def initialize
    @data = File.readlines('day_1.txt', chomp: true).map(&:to_i)
  end

  def call
    res  = 0
    res2 = 0

    (0...data.size).each do |n|
      res  += 1 if data[n].to_i < data[n + 1].to_i
      res2 += 1 if sum_of_measurements(n) < sum_of_measurements(n + 1)
    end

    puts "1: #{res}, 2: #{res2}"
  end

  def sum_of_measurements(idx)
    data[idx].to_i + data[idx + 1].to_i + data[idx + 2].to_i
  end
end

Day1.new.call
