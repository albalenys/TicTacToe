class Game
  def initialize
    @board = (0..8).to_a
    @com = "X"
    @hum = "O"
    @current_spot = nil
  end

  def start_game
    system("clear")
    puts "Welcome to Tic Tac Toe!"
    puts "Please select your spot."
    puts "\n"
    puts self
    until game_is_over(@board) || tie(@board)
      get_human_spot
      system("clear")
      puts "You moved to position #{@current_spot}."
      get_comp_spot
      puts "Computer moved to position #{@current_spot}."
      puts "\n"
      puts self
    end
    puts "Game over"
  end

  def get_human_spot
    end_of_turn = false
    until end_of_turn
      spot = gets.chomp
      if ("a".."z").to_a.include?(spot) || !@board.include?(spot.to_i)
        system("clear")
        puts "Invalid input; please select an unoccupied spot."
        puts "\n"
        puts self
      else
        @board[spot.to_i] = @hum
        @current_spot = spot
        end_of_turn = true
      end
    end
  end

  def get_comp_spot
    end_of_turn = false
    until end_of_turn
      if @board[4] == "4"
        @board[4] = @com
        end_of_turn = true
      else
        spot = get_best_move(@board, @com)
        if @board[spot] != @com && @board[spot] != @hum
          @board[spot] = @com
          @current_spot = spot
          end_of_turn = true
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
      return available_spots.sample.to_i
    end
  end

  def game_is_over(board)
    init = 0
    until init > 6
      return true if [board[init], board[init + 1], board[init + 2]].uniq.length == 1
      init += 3
    end
    # [board[0], board[1], board[2]].uniq.length == 1 ||
    # [board[3], board[4], board[5]].uniq.length == 1 ||
    # [board[6], board[7], board[8]].uniq.length == 1 ||
    # [board[0], board[3], board[6]].uniq.length == 1 ||
    # [board[1], board[4], board[7]].uniq.length == 1 ||
    # [board[2], board[5], board[8]].uniq.length == 1 ||
    # [board[0], board[4], board[8]].uniq.length == 1 ||
    # [board[2], board[4], board[6]].uniq.length == 1
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
