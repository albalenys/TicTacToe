class Game
  def initialize
    @board = (1..9).to_a
    @com = "X"
    @hum = "O"
    @current_spot = nil
    @winner = nil
    @game_type = nil
  end

  def start_game
    system("clear")
    puts "Welcome to Tic Tac Toe!"
    puts "First player to get three in a row wins."
    puts "Choose from the following gaming options."
    puts "\n"
    puts "1. Player vs. Computer"
    puts "2. Player vs. Player (not yet implemented)"
    puts "3. Computer vs. Computer (not yet implemented)"
    choose_game_type

    system("clear")
    if @game_type == "1"
      puts "You chose Player vs. Computer. Good luck! (You will need it.)"
      puts "Choose to play as either 'X' or 'O'."
      choose_marker
      system("clear")
      puts "Please select your spot."
      puts "\n"
      puts self
      until game_is_over(@board) || tie(@board)
        get_human_spot
        system("clear")
        puts "You moved to position #{@current_spot}."
        get_comp_spot
        puts "'#{@com}' moved to position #{@current_spot}."
        puts "\n"
        puts self
      end

    elsif @game_type == "2"
      puts "You chose Player vs. Player."
    else
      puts "You chose Computer vs. Computer. Enjoy the show!"
    end

    if tie(@board)
      puts "Game over. You tied with '#{@com}'."
    else
      puts "Game over. #{@winner} has won."
    end
  end

  private

  def choose_game_type
    @game_type = gets.chomp
    until @game_type == "1"
      puts "Invalid input; please choose options 1 through 3."
      @game_type = gets.chomp
    end
  end

  def choose_marker
    @hum = gets.chomp.upcase!
    until @hum == "X" || @hum == "O"
      puts "Please select to play as either 'X' or 'O'."
      @hum = gets.chomp.upcase!
    end
    if @hum == 'X'
      @com = 'O'
    else
      @com = 'X'
    end
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
        @board[spot.to_i - 1] = @hum
        @current_spot = spot
        end_of_turn = true
      end
    end
  end

  def get_comp_spot
    end_of_turn = false
    until end_of_turn
      if @board[4] == "5"
        @board[4] = @com
        end_of_turn = true
      else
        spot_index = get_best_move(@board, @com)
        if @board[spot_index] != @com && @board[spot_index] != @hum
          @board[spot_index] = @com
          @current_spot = spot_index + 1
          end_of_turn = true
        end
      end
    end
  end

  def get_best_move(board, next_player, depth = 0)
    available_spots = []
    best_move = nil

    board.each do |spot|
      unless spot == @com || spot == @hum
        available_spots << spot
      end
    end

    available_spots.each do |spot|
      spot_index = (spot - 1).to_i
      board[spot_index] = @com
      if game_is_over(board)
        best_move = spot_index
        board[spot_index] = spot
        @winner = "Computer"
        return best_move
      else
        board[spot] = @hum
        if game_is_over(board)
          best_move = spot_index
          board[spot_index] = spot
          return best_move
        else
          board[spot_index] = spot
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
    " _________________\n|     |     |     |\n|  #{@board[0]}  |  #{@board[1]}  |  #{@board[2]}  |\n|_____|_____|_____|\n|     |     |     |\n|  #{@board[3]}  |  #{@board[4]}  |  #{@board[5]}  |\n|_____|_____|_____|\n|     |     |     |\n|  #{@board[6]}  |  #{@board[7]}  |  #{@board[8]}  |\n|_____|_____|_____|"
  end

end

game = Game.new
game.start_game
