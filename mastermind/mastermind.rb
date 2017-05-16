class Player
  attr_reader :name
  attr_accessor :setter_code, :guesses

  def initialize
    guesser_setup
    setter_setup
  end

  def guesser_setup
    puts 'What is your name?'
    @name = gets.chomp.capitalize
    @guesses = 1
  end

  def setter_setup
    puts "\n#{@name} the computer is going to set the code you need to guess."
    puts 'The computer will choose 4 out of a selection of 5 colors.'
    puts 'The color options are - red, blue, orange, green and yellow.'
    puts 'An O represents a color in the right place. An o represents a correct color in the wrong place.'
    @setter_code = %w[red blue orange green yellow red blue orange green yellow].sample(4)
  end
end

class Game
  attr_accessor :player_guess

  def initialize
    @player = Player.new
    @player_guess = []
    @result = []
  end

# gets user guess and shovels a copy into player guess so that original guess
# is not overwritten by changes made in check_code.
# also shovels a copy of @player.setter_code into a new variable so that after each check_code turn
# @player.setter_code is reset to original values.
  def setup
    puts "\n#{@player.name}, please enter guess number #{@player.guesses}:"
    @guess = gets.chomp.downcase.split(' ')
    @player_guess << @guess.map { |col| col }
    @setter_code = @player.setter_code.map { |col| col }
  end

# checks if the guess inputted matches the code to be cracked.
  def player_win
    if @guess == @player.setter_code
      puts "\nYOU HAVE GUESSED THE CORRECT CODE! WOOHOO!"
      return true
    end
  end

  def previous_guesses(guesses)
    if guesses > 1
      puts "\nPrevious guesses - "
      @player_guess.each { |guess| puts guess.join(' ') }
    end
  end

  def game_over(guesses)
    if guesses > 12
      puts "GAME OVER! You're out of moves! \nThe code was: #{@player.setter_code.join(' ')}"
      return true
    end
  end

# function to deal with end of turn information - puts result of guess to user, adds that guess count
# to guesses and creates a new empty results array for next turn.
  def turn_info
    puts "\nResult: " + @result.shuffle.join('')
    @player.guesses += 1
    @result = []
  end

# main game logic. checks if color and position or color but not position match the setter code.
# use of ? ! makes sure that no color can be checked and counted twice.
# implementation makes sure that if the setter_code contains same color twice, that this is accounted for.
  def check_code
    @setter_code.each_with_index do |color, i|
      @guess.each_with_index do |user_color, n|
        if color == @guess[i]
          @result << 'O'
          @setter_code[i] = '?'
          @guess[i] = '!'
          break
        elsif (i != n) && (color == user_color)
          @result << 'o'
          @setter_code[i] = '?'
          @guess[n] = '!'
          break
        end
      end
      break unless (@setter_code & @guess).any?
    end
  end

# implements all of game play. loops until player either wins(player_win) or runs out of moves(game_over)
  def play
    loop do
      setup
      previous_guesses(@player.guesses)
      break if player_win
      check_code
      turn_info
      break if game_over(@player.guesses)
    end
  end
end

Game.new.play
# GUESS MUST NOT INCLUDE ANY QUOTES -
# ie input should be exactly = red blue green yellow
