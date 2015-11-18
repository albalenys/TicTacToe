class Game
  attr_accessor :board, :last_move, :current_player, :winner, :type, :player_1, :player_2

  def initialize
    @board = Array(1..9)
    @player_1 = nil
    @player_2 = nil
    @last_move = nil
    @current_player = nil
    @winner = nil
    @type = nil
  end

  def switch_player
    if @current_player == @player_1
      @current_player = @player_2
    else
      @current_player = @player_1
    end
  end

  def get_type
    @type = gets.chomp

    until (@type == "1" || @type == "2" || @type == "3")
      puts "Invalid input; please choose options 1, 2, or 3."
      @type = gets.chomp
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

  def self.is_over?(board)
    [board[0], board[1], board[2]].uniq.length == 1 ||
    [board[3], board[4], board[5]].uniq.length == 1 ||
    [board[6], board[7], board[8]].uniq.length == 1 ||
    [board[0], board[3], board[6]].uniq.length == 1 ||
    [board[1], board[4], board[7]].uniq.length == 1 ||
    [board[2], board[5], board[8]].uniq.length == 1 ||
    [board[0], board[4], board[8]].uniq.length == 1 ||
    [board[2], board[4], board[6]].uniq.length == 1
  end

  def self.is_tied?(board)
    board.all? { |spots| spots == 'X' || spots == 'O' }
  end

  def to_s
    " _________________\n|     |     |     |\n|  #{@board[0]}  |  #{@board[1]}  |  #{@board[2]}  |\n|_____|_____|_____|\n|     |     |     |\n|  #{@board[3]}  |  #{@board[4]}  |  #{@board[5]}  |\n|_____|_____|_____|\n|     |     |     |\n|  #{@board[6]}  |  #{@board[7]}  |  #{@board[8]}  |\n|_____|_____|_____|"
  end
end
