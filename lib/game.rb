require_relative 'view'
require_relative 'game'
require_relative 'player'
require_relative 'board'

class Game
  attr_accessor :board, :last_move, :current_player, :winner, :type
  attr_reader :player_1, :player_2

  def initialize
    @board = Board.new
    @player_1 = nil
    @player_2 = nil
    @last_move = nil
    @current_player = nil
    @winner = nil
    @type = nil

    instructions
  end

  def start_game
    gaming_options_text
    get_type
    system("clear")
    puts "-----------"
    create_players
    puts "-----------"
    puts "\n"
    @player_1.get_marker(@player_2)
    first_turn_options_text(self)
    get_first_player_turn
    system("clear")

    until (@board.three_in_row? || @board.all_spots_taken?)
      header(self)
      puts "\nPlayer '#{@current_player.marker}' moved to position #{@last_move}.\n" if @last_move
      puts @board
      switch_player
      next_turn_text(self)
      @last_move = @current_player.get_move(@board)
      @winner = @current_player if @board.three_in_row?
      system("clear")
    end

    header(self)
    end_game_text(self)
  end

  def switch_player
    @current_player == @player_1 ? @current_player = @player_2 : @current_player = @player_1
  end

  def get_type
    @type = gets.chomp

    until (@type == "1" || @type == "2" || @type == "3")
      puts "Invalid input; please choose options 1, 2, or 3.".colorize(:red )
      @type = gets.chomp
    end
  end

  def create_players
    if @type == "1"
      puts "You chose Player vs. Computer."
      puts "Choose to play as either 'X' or 'O'."
      @player_1 = Player.new("human")
      @player_2 = Player.new("computer")
    elsif @type == "2"
      puts "You chose Player vs. Player."
      puts "Player 1, choose to play as either 'X' or 'O'."
      @player_1 = Player.new("human")
      @player_2 = Player.new("human")
    else
      puts "You chose Computer vs. Computer."
      puts "Please choose either 'X' or 'O' for Player 1."
      @player_1 = Player.new("computer")
      @player_2 = Player.new("computer")
    end
  end

  def get_first_player_turn
    player_marker = gets.chomp.upcase!

    until (player_marker == "X" || player_marker == "O")
      puts "Invalid input; please select either 'X' or 'O'.".colorize(:red )
      player_marker = gets.chomp.upcase!
    end

    player_marker == @player_1.marker ? @current_player = @player_2 : @current_player = @player_1
  end
end

game = Game.new
game.start_game
