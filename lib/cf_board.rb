# frozen_string_literal: true

# creates game board and manages game logic
class CFBoard
	def initialize
		@board_cells = Array.new(6) { Array.new(7, " ") }
	end

	def display
		puts '-----------------------------'
		n = 0
		while n < 6 do
			puts "| #{@board_cells[n].join(' | ')} |"
			puts '-----------------------------'
			n += 1
		end
	end

	def add(subarray, cell)
		@board_cells[subarray][cell] = "X"
	end
end