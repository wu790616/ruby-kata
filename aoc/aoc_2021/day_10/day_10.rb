class Day10
  attr_accessor :data, :match_map, :score_map, :score_map_p2

  def initialize
    @data         = File.readlines('day_10.txt', chomp: true)
    @match_map    = { '(' => ')', '[' => ']', '{' => '}', '<' => '>' }
    @score_map    = { ')' => 3, ']' => 57, '}' => 1197, '>' => 25_137 }
    @score_map_p2 = { ')' => 1, ']' => 2, '}' => 3, '>' => 4 }
  end

  def call
    puts "1: #{part1}, 2:#{part2}"
  end

  def part1
    data.dup.map do |line|
      remove_match(line)
      find_incorrect_score(line)
    end.compact.sum
  end

  def part2
    res = data.dup.map do |line|
      remove_match(line)
      find_incomplete_score(line) unless find_incorrect_score(line)
    end.compact.sort

    res[res.size / 2]
  end

  def remove_match(line)
    pattern = Regexp.new('\{\}|\[\]|\(\)|\<\>')

    line.gsub!(pattern, '') while line.match(pattern)
  end

  def find_incorrect_score(line)
    line_arr = line.split('')

    line_arr.each.with_index do |chr, idx|
      next_chr = line_arr[idx + 1]

      next unless match_map.keys.include?(chr)
      next unless match_map.values.include?(next_chr)

      return score_map[next_chr]
    end

    nil
  end

  def find_incomplete_score(line)
    line_arr = line.split('').reverse

    line_arr.map { |chr| match_map[chr] }.inject(0) do |memo, chr|
      memo *= 5
      memo + score_map_p2[chr]
    end
  end
end

Day10.new.call
