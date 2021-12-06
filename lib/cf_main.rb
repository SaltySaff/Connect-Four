# frozen_string_literal: true

require_relative '../lib/cf_board'
require_relative '../lib/cf_game'
require_relative '../lib/cf_player'

board = CFBoard.new
board.display
board.add(1, 0)
board.display
