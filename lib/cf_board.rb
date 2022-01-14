# frozen_string_literal: true

require 'colorize'

# creates game board and manages game logic
class CFBoard
  MOVES = [[-1, 1], [0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0]].freeze
  def initialize
    @board_cells = Array.new(6) { Array.new(7, ' ') }
    @piece = {
      'yellow' => "\u{23fa}".yellow,
      'red' => "\u{23fa}".red
    }
  end

  def display
    puts '  1   2   3   4   5   6   7  '.green
    puts '+---+---+---+---+---+---+---+'.blue
    n = 0
    while n < 6
      puts "#{'|'.blue} #{@board_cells[n].join(' | '.blue)} #{'|'.blue}"
      puts '+---+---+---+---+---+---+---+'.blue
      n += 1
    end
  end

  def add(color, column)
    column_index = column - 1
    return nil if get_bottom_cell(column_index).nil?

    @board_cells[get_bottom_cell(column_index)][column_index] = @piece[color]
  end

  def get_bottom_cell(column_index)
    stack = []
    n = 0
    while n < 6
      stack.unshift(n) if @board_cells[n][column_index] == ' '
      n += 1
    end
    return nil if stack.empty?

    stack[0]
  end

  def game_over_test?(color)
    over_vertically?(color)
  end

  def over_horizontally?(color)
    consecutive_pieces = 1
    @board_cells.each do |row|
      row.each_with_index do |cell, index|
        return true if consecutive_pieces >= 4

        if cell == @piece[color] && row[index - 1] == cell
          consecutive_pieces += 1
          next
        end
        consecutive_pieces = 1
      end
    end
    false
  end

  def over_vertically?(color)
    consecutive_pieces = 1
    @board_cells[0].each_with_index do |_cell, index|
      row = 0
      current_cell = @board_cells[row][index]
      while row <= 4
        p row
        return true if consecutive_pieces == 4

        consecutive_pieces = 1 if current_cell != @piece[color]
        consecutive_pieces += 1 if current_cell == @piece[color] && @board_cells[row - 1][index] == current_cell
        row += 1
        current_cell = @board_cells[row][index]
      end
    end
  end

  def game_over?(subarray, column_index)
    find_consecutive_pieces(subarray, column_index) == 4
  end

  def find_consecutive_pieces(subarray, column_index)
    neighbours = get_neighbours(subarray, column_index)
    stack = []
    consecutive_piece = []
    stack << neighbours[0]
    loop do
      return consecutive_piece.max if stack.empty?
    end
  end

  def get_neighbours(subarray, column_index)
    neighbours = []
    MOVES.each do |move|
      n = 1
      3.times do
        neighbours << [subarray + (move[0] * n), column_index + (move[1] * n)]
        n += 1
      end
    end
    neighbours.select { |neighbour| (0..5).include?(neighbour[0]) && (0..6).include?(neighbour[1]) }
  end

  def test_add(row, column, color)
    # adds a piece anywhere on the board for testing
    @board_cells[row][column] = @piece[color]
  end
end



