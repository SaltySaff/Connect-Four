# frozen_string_literal: true

require_relative '../lib/cf_board'
require_relative '../lib/cf_game'
require_relative '../lib/cf_player'

board = CFBoard.new
7.times do
  board.add('yellow', 1)
end
board.display
