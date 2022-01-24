# frozen_string_literal: true

require 'colorized_string'

require_relative '../lib/cf_board'
require_relative '../lib/cf_game'
require_relative '../lib/cf_player'

# board = CFBoard.new
# 3.times do
#   board.add('yellow', 1)
# end
# board.display
# p board.game_over?(0, 0, 'yellow')
p ColorizedString.colors
game = CFGame.new
game.play_game
