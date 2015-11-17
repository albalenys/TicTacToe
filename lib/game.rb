require_relative 'game_helper'
require_relative 'models/player'

class Game
  def initialize
    @board = Array(1..9)
    @player_1 = nil
    @player_2 = nil
    @last_move = nil
    @current_player = nil
    @winner = nil
    @game_type = nil
  end

  def start_game
    system("clear")
    puts "_____ ___  __  _____     __  _____  __  ____"
    puts "  |    |  |      |  /\\  |      |   |  | |--"
    puts "  |   _|_ \\__    | /--\\ \\__    |   \\__/ |___"
    puts "\n"
    puts "Welcome to Tic Tac Toe!"
    puts "First player to get three in a row wins."
    puts "Choose from the following gaming options (1, 2, or 3)."
    puts "\n[ 1 ] Player vs. Computer"
    puts "[ 2 ] Player vs. Player"
    puts "[ 3 ] Computer vs. Computer"
    puts "\n"
    get_game_type
    system("clear")

    puts "-----------"
    if @game_type == "1"
      puts "You chose Player vs. Computer."
      @player_1 = Player.new("human")
      @player_2 = Player.new("computer")
      puts "Choose to play as either 'X' or 'O'."
    elsif @game_type == "2"
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
    puts "-----------"
    puts "\n"
    @player_1.get_marker
    @player_1.marker == 'X' ? @player_2.marker = 'O' : @player_2.marker = 'X'
    system("clear")

    puts "-----------"
    puts "Player 1 will be #{@player_1.marker}."
    puts "Please choose who goes first. Enter 'X' or 'O'."
    puts "-----------"
    puts "\n"
    get_first_player_turn
    system("clear")

    until (Game.game_is_over?(@board) || game_is_tied?)
      header
      puts "\nPlayer '#{@current_player.marker}' moved to position #{@last_move}.\n" if @last_move
      puts self
      switch_player
      puts "\nIt is now Player '#{@current_player.marker}'s turn."

      if @current_player.type == "computer"
        print "Player '#{@current_player.marker}' is looking for next move"
        counter
      end
      @current_player.get_move(@board, @last_move)
      @winner = @current_player if Game.game_is_over?(@board)
      system("clear")
    end

    header
    if game_is_tied?
      puts "\nGame over. Player '#{@player_1.marker}' and player '#{@player_2.marker}' have tied."
    else
      puts "\nGame over. Player '#{@winner.marker}' has won!"
    end
    puts self
    puts "\n"
  end

  private

  def switch_player
    if @current_player == @player_1
      @current_player = @player_2
    else
      @current_player = @player_1
    end
  end

  def Game.next_player(current_player)
    current_player == @player_1 ? @player_2 : @player_1
  end

  def get_game_type
    @game_type = gets.chomp

    until (@game_type == "1" || @game_type == "2" || @game_type == "3")
      puts "Invalid input; please choose options 1, 2, or 3."
      @game_type = gets.chomp
    end
  end

  def get_first_player_turn
    marker = gets.chomp.upcase!

    until (marker == "X" || marker == "O")
      puts "Invalid input; please select either 'X' or 'O'."
      marker = gets.chomp.upcase!
    end

    if marker == @player_1.marker
      @current_player = @player_1
    else
      @current_player = @player_2
    end

    switch_player #switching players to follow the game flow.
  end

  def self.game_is_over?(board)
    [board[0], board[1], board[2]].uniq.length == 1 ||
    [board[3], board[4], board[5]].uniq.length == 1 ||
    [board[6], board[7], board[8]].uniq.length == 1 ||
    [board[0], board[3], board[6]].uniq.length == 1 ||
    [board[1], board[4], board[7]].uniq.length == 1 ||
    [board[2], board[5], board[8]].uniq.length == 1 ||
    [board[0], board[4], board[8]].uniq.length == 1 ||
    [board[2], board[4], board[6]].uniq.length == 1
  end

  def game_is_tied?
    @board.all? { |spots| spots == 'X' || spots == 'O' }
  end

  def to_s
    " _________________\n|     |     |     |\n|  #{@board[0]}  |  #{@board[1]}  |  #{@board[2]}  |\n|_____|_____|_____|\n|     |     |     |\n|  #{@board[3]}  |  #{@board[4]}  |  #{@board[5]}  |\n|_____|_____|_____|\n|     |     |     |\n|  #{@board[6]}  |  #{@board[7]}  |  #{@board[8]}  |\n|_____|_____|_____|"
  end
end

game = Game.new
game.start_game
