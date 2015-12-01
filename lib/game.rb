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
  end

  def setup
    instructions
    gaming_options_text
    get_type
    system("clear")
    puts "-----------"
    create_players
    puts "-----------"
    puts "\n"
    @player_1.get_marker(@player_2)
    first_turn_options_text(@player_1)
    get_first_player_turn
    system("clear")
  end

  def start
    until (@board.three_in_row? || @board.all_spots_taken?)
      header(self)
      puts "\nPlayer '#{@current_player.marker}' moved to position #{@last_move}.\n" if @last_move
      puts @board
      switch_player
      next_turn_text(@current_player)
      @last_move = @current_player.get_move(@board)
      @winner = @current_player if @board.three_in_row?
      system("clear")
    end
    header(self)
    end_game_text(self)
    gets
  end

  private

  def switch_player
    @current_player == @player_1 ? @current_player = @player_2 : @current_player = @player_1
  end

  def get_type
    @type = gets.chomp
    until (@type == "1" || @type == "2" || @type == "3")
      error_message(1)
      @type = gets.chomp
    end
  end

  def create_players
    if @type == "1"
      get_marker_prompt(1)
      @player_1 = Player.new("human")
      @player_2 = Player.new("computer")
    elsif @type == "2"
      get_marker_prompt(2)
      @player_1 = Player.new("human")
      @player_2 = Player.new("human")
    else
      get_marker_prompt(3)
      @player_1 = Player.new("computer")
      @player_2 = Player.new("computer")
    end
  end

  def get_first_player_turn
    player_marker = gets.chomp.upcase!
    until (player_marker == "X" || player_marker == "O")
      error_message(2)
      player_marker = gets.chomp.upcase!
    end
    player_marker == @player_1.marker ? @current_player = @player_2 : @current_player = @player_1
  end
end

game = Game.new
game.setup
game.start
