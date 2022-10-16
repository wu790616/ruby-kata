class Day14
  attr_accessor :data, :pair_rule

  def initialize
    @data      = File.readlines('day_14.txt', chomp: true)
    @pair_rule = init_pair_rule
  end

  def call
    part1 = find_res(10)
    part2 = find_res(40)

    puts "1: #{part1}, 2: #{part2}"
  end

  def find_res(step)
    template   = transform(step, init_template)
    count_char = count_char(template)

    max_count = (count_char.values.max / 2.to_f).ceil
    min_count = (count_char.values.min / 2.to_f).ceil

    max_count - min_count
  end

  def init_pair_rule
    data.drop(2).each_with_object({}) do |polymer, res|
      key, insert = polymer.split(' -> ')

      res.merge!(key => %W[#{key[0] + insert} #{insert + key[1]}])
    end
  end

  def init_template
    temp = data.first

    (0...temp.size - 1).each_with_object({}) do |idx, res|
      res.merge!(temp[idx] + temp[idx + 1] => 1)
    end
  end

  def transform(step, template)
    return template if step.zero?

    new_temp = template.each_with_object({}) do |temp, res|
      key, value = temp

      pair_rule[key].each do |k|
        res[k] = res.key?(k) ? res[k] + value : value
      end
    end

    transform(step - 1, new_temp)
  end

  def count_char(template)
    template.each_with_object({}) do |temp, res|
      temp[0].split('').each do |char|
        res[char] = res.key?(char) ? res[char] + temp[1] : temp[1]
      end
    end
  end
end

Day14.new.call
