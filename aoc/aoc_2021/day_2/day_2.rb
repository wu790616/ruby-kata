class Day2
  attr_accessor :data

  def initialize
    @data = File.readlines('day_2.txt', chomp: true).map do |line|
      item = line.split("\s")
      [item[0], item[1].to_i]
    end
  end

  def call
    puts "1: #{part1}, 2: #{part2}"
  end

  def part1
    ctx = { horizon: 0, depth: 0 }

    data.each do |op, value|
      case op
      when 'forward' then ctx[:horizon] += value
      when 'down'    then ctx[:depth] += value
      when 'up'      then ctx[:depth] -= value
      end
    end

    ctx[:horizon] * ctx[:depth]
  end

  def part2
    ctx = { horizon: 0, depth: 0, aim: 0 }

    data.each do |op, value|
      case op
      when 'forward'
        ctx[:horizon] += value
        ctx[:depth]   += ctx[:aim] * value
      when 'down' then ctx[:aim] += value
      when 'up'   then ctx[:aim] -= value
      end
    end

    ctx[:horizon] * ctx[:depth]
  end
end

Day2.new.call
