# frozen_string_literal: true

require_relative '../lib/cf_board'
require_relative '../lib/cf_game'
require_relative '../lib/cf_player'

board = CFBoard.new
neighbours = board.get_neighbours(2, 4)
p neighbours
neighbours.each do |neighbour|
  board.test_add(neighbour[0], neighbour[1], 'yellow')
end
board.display

