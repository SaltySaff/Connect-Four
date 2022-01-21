# frozen_string_literal: true

# controls flow of game
class CFGame
  def initialize; end

  def play_game
    greeting
    choice = player_input(1, 4)
  end

  def greeting
    puts 'Welcome to Connect 4.'
    puts ' 1. New Game'
    puts ' 2. Load Game'
    puts ' 3. Exit'
    puts ' 4. How to Play'
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
end
