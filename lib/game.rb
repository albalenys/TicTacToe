class Game
  def initialize
    @board = Array(0..8)
    @com = "X"
    @hum = "O"
  end

  def start_game
    puts "Welcome to my Tic Tac Toe game"
    puts self
    puts "Please select your spot."
    until game_is_over(@board) || tie(@board)
      get_human_spot
      get_comp_spot
      puts self
    end
    puts "Game over"
  end

  def get_human_spot
    spot = nil
    until spot
      spot = gets.chomp.to_i
      if !@board.include?(spot)
        puts "Invalid input, please select 0-9."
        spot = nil
      elsif @board[spot] != @com && @board[spot] != @hum
        @board[spot] = @hum
      else
        spot = nil
      end
    end
  end

  def get_comp_spot
    spot = nil
    until spot
      if @board[4] == "4"
        spot = 4
        @board[spot] = @com
      else
        spot = get_best_move(@board, @com)
        if @board[spot] != @com && @board[spot] != @hum
          @board[spot] = @com
        else
          spot = nil
        end
      end
    end
  end

  def get_best_move(board, next_player, depth = 0, best_score = {})
    available_spots = []
    best_move = nil

    board.each do |spot|
      if spot != @com && spot != @hum
        available_spots << spot
      end
    end

    available_spots.each do |spot|
      board[spot.to_i] = @com
      if game_is_over(board)
        best_move = spot.to_i
        board[spot.to_i] = spot
        return best_move
      else
        board[spot.to_i] = @hum
        if game_is_over(board)
          best_move = spot.to_i
          board[spot.to_i] = spot
          return best_move
        else
          board[spot.to_i] = spot
        end
      end
    end
    if best_move
      return best_move
    else
      n = rand(0..available_spots.count)
      return available_spots[n].to_i
    end
  end

  def game_is_over(board)
    [board[0], board[1], board[2]].uniq.length == 1 ||
    [board[3], board[4], board[5]].uniq.length == 1 ||
    [board[6], board[7], board[8]].uniq.length == 1 ||
    [board[0], board[3], board[6]].uniq.length == 1 ||
    [board[1], board[4], board[7]].uniq.length == 1 ||
    [board[2], board[5], board[8]].uniq.length == 1 ||
    [board[0], board[4], board[8]].uniq.length == 1 ||
    [board[2], board[4], board[6]].uniq.length == 1
  end

  def tie(board)
    board.all? { |spots| spots == @com || spots == @hum }
  end

  def to_s
    "|_#{@board[0]}_|_#{@board[1]}_|_#{@board[2]}_|\n|_#{@board[3]}_|_#{@board[4]}_|_#{@board[5]}_|\n|_#{@board[6]}_|_#{@board[7]}_|_#{@board[8]}_|\n"
  end

end

game = Game.new
game.start_game
