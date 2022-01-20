# frozen_string_literal: true

require 'colorize'

# creates game board and manages game logic
class CFBoard
  MOVES = [[-1, 1], [1, -1], [0, 1], [0, -1], [1, 1], [-1, -1], [1, 0], [-1, 0]].freeze
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
    neighbours = calc_neighbours(subarray, column_index)
    format_neighbours(filter_neighbours(neighbours), subarray, column_index)
  end

  def calc_neighbours(subarray, column_index)
    neighbours = []
    MOVES.each do |move|
      n = 1
      sub_array = []
      3.times do
        sub_array << [subarray + (move[0] * n), column_index + (move[1] * n)]
        n += 1
      end
      neighbours << sub_array
    end
    neighbours
  end

  def filter_neighbours(neighbours)
    filtered_neighbours = []
    neighbours.each do |neighbour_array|
      filtered_neighbours.push(neighbour_array.select { |neighbour| (0..5).include?(neighbour[0]) && (0..6).include?(neighbour[1]) } )
    end
    filtered_neighbours
  end

  def format_neighbours(filtered_neighbours, subarray, column_index)
    p filtered_neighbours
    root = [[subarray, column_index]]
    test = filtered_neighbours[0].reverse + root + filtered_neighbours[1]
    p test
  end

  def test_add(row, column, color)
    # adds a piece anywhere on the board for testing
    @board_cells[row][column] = @piece[color]
  end
end


