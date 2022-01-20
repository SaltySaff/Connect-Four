# frozen_string_literal: true

require_relative '../lib/cf_board'
require_relative '../lib/cf_game'
require_relative '../lib/cf_player'

board = CFBoard.new
neighbours = board.get_neighbours(3, 3)
neighbours.each do |neighbour_array|
  neighbour_array.each do |neighbour|
    board.test_add(neighbour[0], neighbour[1], 'yellow')
  end
end
board.display
