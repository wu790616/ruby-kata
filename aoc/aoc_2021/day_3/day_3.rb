class Day3
  attr_accessor :data

  def initialize
    @data = File.readlines('day_3.txt', chomp: true)
  end

  def call
    puts "1: #{part1}, 2: #{part2}"
  end

  def part1
    trans_data = data.map { |item| item.split('') }.transpose
    half_size  = trans_data.first.size / 2

    gamma_rate = trans_data.map do |item|
      sorted_item = item.sort
      sorted_item[half_size]
    end

    epsilon_rate = gamma_rate.map { |n| transform_epsilon(n) }

    gamma_rate.join.to_i(2) * epsilon_rate.join.to_i(2)
  end

  def part2
    oxygen_rate = find_oxygen_rate # 2039
    co2_rate    = find_co2_rate    # 3649

    oxygen_rate * co2_rate
  end

  private

  def transform_epsilon(num)
    n_map = {
      '0' => '1',
      '1' => '0'
    }

    n_map[num]
  end

  def find_oxygen_rate
    oxygen_data = data.dup

    loop.with_index do |_, idx|
      item       = oxygen_data.map { |num| num.split('') }.transpose.at(idx)
      count_zero = item.count('0')
      count_one  = item.count('1')

      oxygen_data = if count_one >= count_zero
                      oxygen_data.select { |num| num[idx] == '1' }.take(count_one)
                    else
                      oxygen_data.select { |num| num[idx] == '0' }.take(count_zero)
                    end

      return oxygen_data.last.to_i(2) if oxygen_data.size == 1
    end
  end

  def find_co2_rate
    co2_data = data.dup

    loop.with_index do |_, idx|
      item       = co2_data.map { |num| num.split('') }.transpose.at(idx)
      count_zero = item.count('0')
      count_one  = item.count('1')

      co2_data = if count_zero <= count_one
                   co2_data.select { |num| num[idx] == '0' }.take(count_zero)
                 else
                   co2_data.select { |num| num[idx] == '1' }.take(count_one)
                 end

      return co2_data.last.to_i(2) if co2_data.size == 1
    end
  end
end

Day3.new.call
