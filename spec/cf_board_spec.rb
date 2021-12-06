# frozen_string_literal: true

require_relative '../lib/cf_board'

describe CFBoard do
  subject(:game_board) { described_class.new() }

  describe '#initialize' do
    it 'creates a nested array of length 6' do
      board_cells = game_board.instance_variable_get(:@board_cells)
      expect(board_cells.length).to eq(6)
    end

    it 'each array in the nested array have a length of 7' do
      board_cells = game_board.instance_variable_get(:@board_cells)
      only_spaces = board_cells.all? { |subarray| subarray.length == 7 }
      expect(only_spaces).to be true
    end

    it 'the cells of each subarray are all spaces' do
      board_cells = game_board.instance_variable_get(:@board_cells)
      only_spaces = board_cells.all? do |subarray|
        subarray.all? { |cells| cells = " "}
      end
      expect(only_spaces).to be true
    end
  end

  describe '#display' do
    it 'creates six rows' do
      expect(game_board).to receive(:puts).exactly(13).times
      game_board.display
    end
  end

  describe '#add' do
    it 'displays symbol in correct cell' do
      board_cells = game_board.instance_variable_get(:@board_cells)
      subarray = 0
      cell = 0
      expect(game_board.add(0, 0)).to eq('X')
    end
  end
end
