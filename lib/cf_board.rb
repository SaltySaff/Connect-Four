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

  def game_over?(subarray, column_index, color)
    neighbour_list = get_neighbours(subarray, column_index)
    find_consecutive_pieces(neighbour_list, 4, color)
  end

  def find_consecutive_pieces(neighbour_list, piece_count, color)
    neighbour_list.each do |line|
      consecutive_count = 0
      line.each do |cell|
        consecutive_count += 1 if @board_cells[cell[0]][cell[1]] == @piece[color]
        consecutive_count = 0 if @board_cells[cell[0]][cell[1]] != @piece[color]
        return true if consecutive_count == piece_count
      end
    end
    false
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
    p filtered_neighbours
  end

  def format_neighbours(filtered_neighbours, subarray, column_index)
    formated_array = []
    n = 0
    until n == filtered_neighbours.length
      formated_line = []
      reversed_array = filtered_neighbours[n].reverse unless filtered_neighbours[n].nil?
      formated_line.concat(reversed_array, [[subarray, column_index]], filtered_neighbours[n + 1])
      formated_array << formated_line
      n += 2
    end
    formated_array
  end

  def test_add(row, column, color)
    # adds a piece anywhere on the board for testing
    @board_cells[row][column] = @piece[color]
  end
end
