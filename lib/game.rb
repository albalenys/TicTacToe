require_relative 'display'
require_relative 'game'
require_relative 'player'
require_relative 'board'
require_relative 'helpers'

class Game
  attr_accessor :type, :current_player, :input
  attr_reader :player_1, :player_2, :board, :winner

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
    Display.instructions
    Display.gaming_options
    get_type
    create_players
    @player_1.get_marker(@player_2)
    Display.first_turn_options(@player_1)
    get_first_turn
  end

  def start
    until (@board.three_in_row? || @board.all_spots_taken?)
      Display.header(self)
      Display.last_move(@current_player, @last_move)
      Display.board(@board.spots)
      switch_player
      Display.next_turn(@current_player)
      @last_move = @current_player.get_move(@board)
      @winner = @current_player if @board.three_in_row?
    end
    Display.header(self)
    Display.final_score(self)
    gets
  end

  private

  def switch_player
    @current_player == @player_1 ? @current_player = @player_2 : @current_player = @player_1
  end

  def get_type
    @type = gets.chomp
    until (@type == "1" || @type == "2" || @type == "3")
      Display.error_message(1)
      @type = gets.chomp
    end
  end

  def create_players
    if @type == "1"
      Display.marker_options(1)
      @player_1 = Player.new("human")
      @player_2 = Player.new("computer")
    elsif @type == "2"
      Display.marker_options(2)
      @player_1 = Player.new("human")
      @player_2 = Player.new("human")
    else
      Display.marker_options(3)
      @player_1 = Player.new("computer")
      @player_2 = Player.new("computer")
    end
  end

  def get_first_turn
    player_marker = gets.chomp.upcase!
    until (player_marker == "X" || player_marker == "O")
      Display.error_message(2)
      player_marker = gets.chomp.upcase!
    end
    player_marker == @player_1.marker ? @current_player = @player_2 : @current_player = @player_1
  end
end