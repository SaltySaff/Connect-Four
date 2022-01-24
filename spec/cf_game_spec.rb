# frozen_string_literal: true

# rubocop: disable Layout/LineLength/BlockLength

require_relative '../lib/cf_game'

describe CFGame do
  subject(:current_game) { described_class.new }

  describe '#change_player_turn' do
    it 'changes the value of @player_turn' do
      current_game.change_player_turn(1)
      current_turn = current_game.instance_variable_get(:@player_turn)
      expect(current_turn).to eq('red')
    end
  end

  describe '#random_choice' do
    it 'returns either red or yellow as a string' do
      red_or_yellow = current_game.random_choice
      expect(red_or_yellow).to eq('red').or eq('yellow')
    end
  end
end
