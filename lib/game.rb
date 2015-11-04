class Game
  def initialize
    @board = (1..9).to_a
    @player_1 = nil
    @player_2 = nil
    @current_spot = nil
    @current_player = nil
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
    puts "2. Player vs. Player"
    puts "3. Computer vs. Computer"
    choose_game_type

    system("clear")
    if @game_type == "1"
      puts "You chose Player vs. Computer."
      puts "Choose to play as either 'X' or 'O'."
      choose_marker
      system("clear")
      @current_player = @player_1

      until game_is_over(@board) || tie(@board)
        puts "-----------"
        puts "Player: '#{@player_1}'"
        puts "Computer: '#{@player_2}'"
        puts "-----------"
        puts "\n"
        puts "Player '#{@current_player}' moved to position #{@current_spot}." if @current_spot
        puts "\n"
        puts self
        puts "Please select your spot."
        get_human_spot(@current_player)
        get_comp_spot
        system("clear")
      end

    elsif @game_type == "2"
      puts "You chose Player vs. Player."
      puts "Player 1, choose to play as either 'X' or 'O'."
      choose_marker
      system("clear")
      @current_player = @player_1

      until game_is_over(@board) || tie(@board)
        puts "-----------"
        puts "Player 1: '#{@player_1}'"
        puts "Player 2: '#{@player_2}'"
        puts "-----------"
        puts "\n"
        puts "Player '#{@current_player}' moved to position #{@current_spot}." if @current_spot
        switch_player
        puts "It is now Player '#{@current_player}'s turn."
        puts "\n"
        puts self
        puts "\n"
        get_human_spot(@current_player)
        system("clear")
      end

    else
      puts "You chose Computer vs. Computer. Enjoy the show!"
    end

    if tie(@board)
      puts "Game over. You tied with '#{@player_2}'."
    else
      puts "Game over. #{@winner} has won."
    end
  end

  private

  def switch_player
    if @current_player == @player_1
      @current_player = @player_2
    else
      @current_player = @player_1
    end
  end

  def choose_game_type
    @game_type = gets.chomp

    until @game_type == "1" || @game_type == "2"
      puts "Invalid input; please choose options 1 or 2."
      @game_type = gets.chomp
    end
  end

  def choose_marker
    @player_1 = gets.chomp.upcase!
    until @player_1 == "X" || @player_1 == "O"
      puts "Please select to play as either 'X' or 'O'."
      @player_1 = gets.chomp.upcase!
    end
    if @player_1 == 'X'
      @player_2 = 'O'
    else
      @player_2 = 'X'
    end
  end

  def get_human_spot(player)
    end_of_turn = false
    until end_of_turn
      spot = gets.chomp
      if ("a".."z").to_a.include?(spot) || !@board.include?(spot.to_i)
        system("clear")
        puts "Invalid input; please select an unoccupied spot."
        puts "\n"
        puts self
      else
        @board[spot.to_i - 1] = player
        @current_spot = spot
        end_of_turn = true
      end
    end
  end

  def get_comp_spot
    end_of_turn = false
    until end_of_turn
      if @board[4] == "5"
        @board[4] = @player_2
        end_of_turn = true
      else
        spot_index = get_best_move(@board, @player_2)
        if @board[spot_index] != @player_2 && @board[spot_index] != @player_1
          @board[spot_index] = @player_2
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
      unless spot == @player_2 || spot == @player_1
        available_spots << spot
      end
    end

    available_spots.each do |spot|
      spot_index = (spot - 1).to_i
      board[spot_index] = @player_2
      if game_is_over(board)
        best_move = spot_index
        board[spot_index] = spot
        @winner = "Computer"
        return best_move
      else
        board[spot] = @player_1
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
    board.all? { |spots| spots == @player_2 || spots == @player_1 }
  end

  def to_s
    " _________________\n|     |     |     |\n|  #{@board[0]}  |  #{@board[1]}  |  #{@board[2]}  |\n|_____|_____|_____|\n|     |     |     |\n|  #{@board[3]}  |  #{@board[4]}  |  #{@board[5]}  |\n|_____|_____|_____|\n|     |     |     |\n|  #{@board[6]}  |  #{@board[7]}  |  #{@board[8]}  |\n|_____|_____|_____|"
  end

end

game = Game.new
game.start_game
