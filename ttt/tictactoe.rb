class Player
  attr_reader :marker, :name
  attr_accessor :guesses

  @@player_number = 0

  def initialize
    @@player_number +=1
    setup_players
  end

  def setup_players
    puts "Player #{@@player_number}: what is your name?"
    @name = gets.chomp
    @marker = @@player_number == 1 ? "X" : "0"
    @guesses = []
  end
end

class Board

  def initialize
    @board_cells = *(0..9)
    @board_cells[0] = nil
  end

  def draw_board
      puts "\n"
      puts " #{@board_cells[1]}  | #{@board_cells[2]}  | #{@board_cells[3]}  "
      puts "-----------"
      puts " #{@board_cells[4]}  | #{@board_cells[5]}  | #{@board_cells[6]}  "
      puts "-----------"
      puts " #{@board_cells[7]}  | #{@board_cells[8]}  | #{@board_cells[9]} "
  end

  def turn(player, guess)
    if guess < 1 || guess > 9
      puts "pick a number between 1 and 9 only."
      return false
    elsif ["X","O"].include? @board_cells[guess]
      puts "Already taken."
      return false
    end
    @board_cells[guess] = player.marker
    player.guesses << guess
  end

  def check_win(moves)
    @possible_wins = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
    @possible_wins.each do |variation|
      return true if variation.select { |i| moves.include? i }.count == 3
    end
    false
  end
end


class Game
  def initialize
    @board = Board.new
    @player = []
    @player << Player.new << Player.new
    @turn_id = 0
  end

  def play
    @board.draw_board
    while true
      puts "\n"
      puts "#{@player[@turn_id].name}, place your #{@player[@turn_id].marker}"
      move = gets.chomp.to_i
    if @board.turn(@player[@turn_id], move)
      @board.draw_board
      if @board.check_win(@player[@turn_id].guesses)
        puts "\n#{@player[@turn_id].name} wins! Good Job!"
        break
      elsif @player[@turn_id].guesses.count > 4
        puts "\nIt's a draw!"
        break
      end
      @turn_id = (@turn_id == 0 ? 1 : 0)
    end
  end
end

end

Game.new.play
