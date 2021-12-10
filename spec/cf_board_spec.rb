# frozen_string_literal: true

require_relative '../lib/cf_board'

describe CFBoard do
  subject(:game_board) { described_class.new }

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
        subarray.all? { |cells| cells == ' ' }
      end
      expect(only_spaces).to be true
    end
  end

  describe '#display' do
    it 'creates six rows' do
      expect(game_board).to receive(:puts).exactly(14).times
      game_board.display
    end
  end

  describe '#add' do
    context 'when placing a piece' do
      context 'and the piece is yellow' do
        it 'adds a yellow piece to the bottom cell of column 1' do
          board_cells = game_board.instance_variable_get(:@board_cells)
          game_board.add('yellow', 1)
          expect(board_cells[5][0]).to eq("\u{23fa}".yellow)
        end
      end

      context 'and the piece is red' do
        it 'adds a red piece to the bottom cell of column 1' do
          board_cells = game_board.instance_variable_get(:@board_cells)
          game_board.add('red', 1)
          expect(board_cells[5][0]).to eq("\u{23fa}".red)
        end
      end
    end

    context 'when a column already contains a piece' do
      it 'doesn\'t add a piece to that cell' do
        board_cells = game_board.instance_variable_get(:@board_cells)
        board_cells[5][0] = "\u{23fa}".red
        game_board.add('yellow', 1)
        expect(board_cells[0][5]).not_to eq("\u{23fa}".yellow)
      end

      it 'adds a piece to the cell above' do
        board_cells = game_board.instance_variable_get(:@board_cells)
        board_cells[5][0] = "\u{23fa}".red
        game_board.add('yellow', 1)
        expect(board_cells[4][0]).to eq("\u{23fa}".yellow)
      end
    end

    context 'when the column is full' do
      it 'returns nil' do
        6.times do
          game_board.add('yellow', 1)
        end
        expect(game_board.add('yellow', 1)).to be_nil
      end
    end
  end

  describe '#get_bottom_cell' do
    context 'when the column is empty' do
      it 'returns the index of the bottom cell' do
        index = game_board.get_bottom_cell(1)
        expect(index).to eq(5)
      end
    end

    context 'when the column has one piece' do
      it 'returns the index of the bottom cell but one' do
        board_cells = game_board.instance_variable_get(:@board_cells)
        board_cells[0][5] = "\u{23fa}".red
        index = game_board.get_bottom_cell(1)
        expect(index).to eq(5)
      end
    end

    context 'when the column is full' do
      it 'returns nil' do
        4.times do
          game_board.add('yellow', 1)
        end
        p game_board
        expect(game_board.get_bottom_cell(1)).to be_nil
      end
    end
  end

  describe '#game_over?' do
    context 'when someone has won' do
      it 'returns true' do
      end
    end
    context 'when no one has won' do
      it 'returns false do' do
      end
    end
  end

  describe '#find_consecutive_pieces' do
    it 'returns the number of consecutive piece' do
    end
  end

  describe '#get_neighbours' do
    context 'when all possible neighbours are on the board' do
      it 'returns an array of the neighbours' do
        subarray = 3
        column_index = 3
        neighbours = game_board.get_neighbours(subarray, column_index)
        expect(neighbours).to eq([[4, 2], [4, 3], [4, 4], [3, 4], [2, 4], [2, 2], [3, 2]])
      end
    end
    context 'when some of the neighbours are off of the board' do
      it 'doesn\'t include those neighbours in the array' do
        subarray = 0
        column_index = 0
        neighbours = game_board.get_neighbours(subarray, column_index)
        expect(neighbours).to eq([[1, 0], [1, 1], [0, 1]])
      end
    end
  end
end
