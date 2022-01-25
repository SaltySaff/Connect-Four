# frozen_string_literal: true

require 'colorize'

# controls flow of game
class CFGame
  attr_accessor :player_turn

  def initialize
    @player_turn = 'yellow'
    @board = CFBoard.new
  end

  def play_game
    greeting
    choice = player_input(1, 4)
    case choice
    when 1
      new_game
    when 2
      load_game
    when 3
      how_to_play
    end
  end

  def greeting
    puts 'Welcome to Connect 4.'.blue
    puts " #{'1.'.blue} #{'New Game'.cyan}"
    puts " #{'2.'.blue} #{'Load Game'.cyan}"
    puts " #{'3.'.blue} #{'How to Play'.cyan}"
    puts " #{'4.'.blue} #{'Exit'.cyan}"
  end

  def player_input(min, max)
    loop do
      user_input = gets.chomp
      verified_number = verify_input(min, max, user_input.to_i) if user_input.match?(/^\d$/)
      return verified_number if verified_number

      puts "Input error! Please enter a number between #{min} and #{max}."
    end
  end

  def verify_input(min, max, input)
    return input if input.between?(min, max)
  end

  def new_game
    choice = player_choice
    change_player_turn(choice)
    place_piece while @board.board_full? == false
  end

  def load_game
    puts 'Loading game...'
  end

  def how_to_play
    puts 'How to play...'
  end

  def player_choice
    puts 'Who wants to go first?'
    puts ' 1. Red'
    puts ' 2. Yellow'
    puts ' 3. Make it random'
    player_input(1, 3)
  end

  def change_player_turn(choice)
    case choice
    when 1
      @player_turn = 'red'
    when 2
      @player_turn = 'yellow'
    when 3
      @player_turn = random_choice
    end
  end

  def switch_turn
    @player_turn = @player_turn == 'yellow' ? 'red' : 'yellow'
  end

  def place_piece
    @board.display
    puts "It's #{@player_turn.colorize(@player_turn.to_sym)}'s turn to place a piece"
    puts 'Please choose a column to place your piece in.'
    choice = validate_placement(player_input(1, 7))
    @board.add(@player_turn, choice)
    switch_turn
  end

  def validate_placement(choice)
    loop do
      return choice if @board.get_bottom_cell(choice - 1)

      puts 'That column is already full! Please choose another column.'
      choice = player_input(1, 7)
    end
  end

  def random_choice
    random_number = rand(1..2)
    p random_number
    case random_number
    when 1
      'red'
    when 2
      'yellow'
    end
  end
end
