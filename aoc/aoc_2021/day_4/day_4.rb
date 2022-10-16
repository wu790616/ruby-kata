require 'set'

class Day4
  attr_accessor :data, :nums, :boards

  def initialize
    @data = File.readlines('day_4.txt', chomp: true)
    @nums = data.first.split(',').map(&:to_i)

    @boards = []
  end

  def call
    create_boards

    part1_res = calculate_score(find_win_board)
    part2_res = calculate_score(find_last_win_board)

    puts "1: #{part1_res}, 2: #{part2_res}"
  end

  private

  def create_boards
    board_data = data.reject(&:empty?)
    board_data.delete_at(0)

    board_data.each_slice(5) do |board_set|
      board = Board.new(board_set)
      boards << board
    end

    boards.each(&:create_lines)
  end

  def calculate_score(last_draw:, board:)
    call_win     = nums[last_draw - 1]
    unmarked_sum = (board.all_nums - nums.take(last_draw)).sum

    call_win * unmarked_sum
  end

  def find_win_board
    (5..nums.size).each do |draw|
      res = boards.select do |board|
        board.lines.any? { |line| (line & nums.take(draw).to_set).size == 5 }
      end

      return { last_draw: draw, board: res.first } unless res.empty?
    end
  end

  def find_last_win_board
    nums.size.downto(5) do |draw|
      res = boards.select do |board|
        board.lines.all? { |line| (line & nums.take(draw).to_set).size != 5 }
      end

      return { last_draw: (draw + 1), board: res.first } unless res.empty?
    end
  end
end

class Board
  attr_accessor :all_nums, :lines

  def initialize(board_set)
    @all_nums = board_set.map do |set|
      set.split(' ').map(&:to_i)
    end.flatten

    @lines = []
  end

  def create_lines
    # rows
    all_nums.each_slice(5) { |row| lines << row.to_set }

    # columns
    (0..4).each do |n|
      column = []
      all_nums.each_slice(5) { |row| column << row[n] }
      lines << column.to_set
    end
  end
end

Day4.new.call
