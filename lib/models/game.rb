class Game
  attr_accessor :board, :last_move, :current_player, :winner
  attr_reader :type, :player_1, :player_2

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
    @current_player == @player_1 ? @current_player = @player_2 : @current_player = @player_1
  end

  def get_type
    @type = gets.chomp

    until (@type == "1" || @type == "2" || @type == "3")
      puts "Invalid input; please choose options 1, 2, or 3."
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
      puts "Invalid input; please select either 'X' or 'O'."
      player_marker = gets.chomp.upcase!
    end

    player_marker == @player_1.marker ? @current_player = @player_2 : @current_player = @player_1
  end

  def self.is_over?(board)
    status = false
    row_start = 0
    col_start = 0

    3.times do
      status = true if self.three_in_row?(board, row_start, 1) || self.three_in_row?(board, col_start, 3)
      row_start += 3
      col_start += 1
    end

    status = true if self.three_in_row?(board, 0, 4) || self.three_in_row?(board, 2, 2)
    status
  end

  def self.is_tied?(board)
    board.all? { |spots| spots == 'X' || spots == 'O' }
  end

  def to_s
    " _________________\n|     |     |     |\n|  #{@board[0]}  |  #{@board[1]}  |  #{@board[2]}  |\n|_____|_____|_____|\n|     |     |     |\n|  #{@board[3]}  |  #{@board[4]}  |  #{@board[5]}  |\n|_____|_____|_____|\n|     |     |     |\n|  #{@board[6]}  |  #{@board[7]}  |  #{@board[8]}  |\n|_____|_____|_____|"
  end

  private

  def self.three_in_row?(board, start, increment)
    [board[start], board[start += increment], board[start += increment]].uniq.length == 1
  end
end
