# frozen_string_literal: true

require 'colorize'

# creates game board and manages game logic
class CFBoard
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

  def game_over?(piece_location)
    find_consecutive_pieces(piece_location) == 4 ? true : false
  end

  def find_consecutive_pieces(piece_location)
    consecutive_pieces = 0
    neighbours = piece_location(get_neighbours)
    piece_type = get_piece_type(piece_location)
    queue = []
    queue << piece_location
    
    visited_pieces = []
    loop do
      return consecutive_pieces if queue.empty?

      if neighbours[0] == piece_type && neighbours.include?(neighbours[0]) == false
        queue << neighbours.shift
        visited_notes << queue.shift
        consecutive_piece += 1
        next
      end
      next
    end
  end
end


[1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 1], [0, 1]