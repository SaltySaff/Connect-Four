# frozen_string_literal: true

# rubocop: disable Layout/LineLength/BlockLength

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
        expect(game_board.get_bottom_cell(1)).to be_nil
      end
    end
  end

  describe '#game_over?' do
    context 'when someone has won' do
      it 'returns true' do
        4.times do
          game_board.add('yellow', 1)
        end
        expect(game_board.game_over?(5, 0, 'yellow')).to be true
      end
    end
    context 'when no one has won' do
      it 'returns false' do
        3.times do
          game_board.add('yellow', 1)
        end
        expect(game_board.game_over?(5, 0, 'yellow')).to be false
      end
    end
  end

  describe '#find_consecutive_pieces' do
    context 'when passed consecutive count matches actual consecutive count' do
      it 'returns true' do
        3.times do
          game_board.add('yellow', 1)
        end
        neighbour_list = [[[2, 3], [3, 2], [4, 1], [5, 0]], [[5, 3], [5, 2], [5, 1], [5, 0]], [[5, 0]], [[5, 0], [4, 0], [3, 0], [2, 0]]]
        expect(game_board.find_consecutive_pieces(neighbour_list, 3, 'yellow')).to be true
      end
    end
    context 'when passed consecutive count does not match actual consecutive count' do
      it 'returns false' do
        3.times do
          game_board.add('yellow', 1)
        end
        neighbour_list = [[[2, 3], [3, 2], [4, 1], [5, 0]], [[5, 3], [5, 2], [5, 1], [5, 0]], [[5, 0]], [[5, 0], [4, 0], [3, 0], [2, 0]]]
        expect(game_board.find_consecutive_pieces(neighbour_list, 4, 'yellow')).to be false
      end
    end
  end

  describe '#get_neighbours' do
    it 'returns a formatted array of possible neighbour cells that could lead to a victory' do
      subarray = 0
      column_index = 0
      neighbours = game_board.get_neighbours(subarray, column_index)
      expect(neighbours).to eq([[[0, 0]], [[0, 3], [0, 2], [0, 1], [0, 0]], [[3, 3], [2, 2], [1, 1], [0, 0]], [[3, 0], [2, 0], [1, 0], [0, 0]]])
    end
  end

  describe '#calc_neighbours' do
    it 'returns unfiltered and unformatted array of neighbours' do
      subarray = 0
      column_index = 0
      neighbours = game_board.calc_neighbours(subarray, column_index)
      expect(neighbours).to eq([[[-1, 1], [-2, 2], [-3, 3]], [[1, -1], [2, -2], [3, -3]], [[0, 1], [0, 2], [0, 3]], [[0, -1], [0, -2], [0, -3]], [[1, 1], [2, 2], [3, 3]], [[-1, -1], [-2, -2], [-3, -3]], [[1, 0], [2, 0], [3, 0]], [[-1, 0], [-2, 0], [-3, 0]]])
    end
  end

  describe 'filter_neighbours' do
    it 'filters passed neighbour list, removing any impossible moves' do
      neighbours = [[[-1, 1], [-2, 2], [-3, 3]], [[1, -1], [2, -2], [3, -3]], [[0, 1], [0, 2], [0, 3]], [[0, -1], [0, -2], [0, -3]], [[1, 1], [2, 2], [3, 3]], [[-1, -1], [-2, -2], [-3, -3]], [[1, 0], [2, 0], [3, 0]], [[-1, 0], [-2, 0], [-3, 0]]]
      filtered_list = game_board.filter_neighbours(neighbours)
      expect(filtered_list).to eq([[], [], [[0, 1], [0, 2], [0, 3]], [], [[1, 1], [2, 2], [3, 3]], [], [[1, 0], [2, 0], [3, 0]], []])
    end
  end

  describe 'board_full?' do
    context 'when the board is full' do
      it 'returns true' do
        piece = game_board.instance_variable_get(:@piece)
        board_cells = game_board.instance_variable_get(:@board_cells)
        board_cells.each do |subarray|
          subarray.each do |board_cell|
            board_cell = piece['red']
            p board_cell
          end
        end
        expect
      end
    end
  end
end
