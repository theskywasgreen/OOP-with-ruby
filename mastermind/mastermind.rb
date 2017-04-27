# how to check if the users input matches the secret code
setter_code = ["red", "blue", "red", "green"]
player_guess = ["blue", "red", "red", "green"]
  if setter_code == player_guess
    player_win
  end
#would return false, they have to be in same order.

def player_win
  print "You have guessed the correct code! \n#{setter_code.join(" ")}"
end

# ORIGINAL ATTEMPT NOW REDUNDANT FOR BELOW METHOD
# semi-working code to check whether any, but not all colors match in position and in color.
# code = ["red", "blue", "red", "green"]
# guess = ["blue", "red", "red", "green"]
# result = []
#  code.each_with_index do |color, i|
#    guess.each_with_index do |user_color, n|
#      if i == n && color == user_color
#          result << user_color
#
#      else
#        puts "no correct guesses"
#      end
#      puts "#{result.length} correct colors in correct positions."
#    end
#  end

# best solution for checking if color and position is correct.
# and then checks to see if remaining colors are included in the code but in wrong position.
# "O" signifies correct position and color. "o" signifies correct color in wrong position.
#setter_code = ["red", "blue", "red", "green"]
#player_guess = ["red", "blue", "blue", "green"]
#result = []
#
#  setter_code.each_with_index do |color, i|
#      if color == player_guess[i]
#          result << "O"
#          setter_code[i] = "?"
#          player_guess[i] = "!"
#      end
#    end
#
#    player_guess.each do |user_color|
#      if setter_code.include? user_color
#        result << "o"
#      end
#    end



# shuffle colors available
color_options = ["red", "blue", "orange", "green", "yellow"].shuffle
# picks 4 of the shuffled colors and sets as the code
setter_code = color_options.sample(4)

# NEW BEST METHOD
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
