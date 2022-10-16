class Day13
  attr_accessor :data, :dots, :instructions

  def initialize
    @data = File.readlines('day_13.txt', chomp: true)
    @dots = []
    @instructions = (878..889).map { |idx| data[idx].gsub!('fold along ', '').split('=') }
  end

  def call
    part1
    part2
  end

  def part1
    init_dots
    trans_dots(instructions.first)

    puts "1: #{dots.size}"
  end

  def part2
    init_dots

    instructions.each { |instr| trans_dots(instr) }
    draw_dots
  end

  def trans_dots(instr)
    value = instr[1].to_i
    idx   = instr[0] == 'x' ? 0 : 1

    dots.reject! { |dot| dot[idx] == value }

    dots.select { |dot| dot[idx] > value }.each do |dot|
      dot[idx] = value - (dot[idx] - value)
    end

    dots.uniq!
  end

  def draw_dots
    max_x = dots.map(&:first).max
    max_y = dots.map(&:last).max

    (0..max_y).each do |y|
      line = (0..max_x).map do |x|
        dots.include?([x, y]) ? '#' : '.'
      end.join

      puts line
    end
  end

  def init_dots
    @dots = (0..876).map { |idx| data[idx].split(',').map(&:to_i) }
  end
end

Day13.new.call
