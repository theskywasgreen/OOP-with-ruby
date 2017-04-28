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
    @color_options = %w[red blue orange green yellow red blue orange green yellow].shuffle
    @setter_code = @color_options.sample(4)
    puts @setter_code
  end
end

# Logic
setter_code = ["red", "red", "blue", "red"]
player_guess = ["red", "purple", "red", "orange"]
result = []

  setter_code.each_with_index do |color, i|
    player_guess.each_with_index do |user_color, n|
        if color == player_guess[i]
            result << "O"
            setter_code[i] = "?"
            player_guess[i] = "!"
            break
        elsif (i!= n) && (color == user_color)
            result << "o"
            setter_code[i] = "?"
            player_guess[n] = "!"
            break
      end
    end
    break if not (setter_code & player_guess).any?
  end
  puts result.join("")
