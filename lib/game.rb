class Game
  def initialize
    @board = Array(1..9)
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
    puts "\n[ 1 ] Player vs. Computer"
    puts "[ 2 ] Player vs. Player"
    puts "[ 3 ] Computer vs. Computer"
    get_game_type
    system("clear")

    if @game_type == "1"
      puts "You chose Player vs. Computer."
      puts "Choose to play as either 'X' or 'O'."
    elsif @game_type == "2"
      puts "You chose Player vs. Player."
      puts "Player 1, choose to play as either 'X' or 'O'."
    else
      puts "You chose Computer vs. Computer."
      puts "Please choose either 'X' or 'O' for Player 1."
    end

    get_marker
    system("clear")

    @game_type == "1" ? @current_player = @player_1: @current_player = @player_2

    until game_is_over(@board) || tie(@board)
      puts "-----------"
      if @game_type == "1"
        puts "Player: '#{@player_1}'"
        puts "Computer: '#{@player_2}'"
      else
        puts "Player 1: '#{@player_1}'"
        puts "Player 2: '#{@player_2}'"
      end
      puts "-----------"
      puts "\nPlayer '#{@current_player}' moved to position #{@current_spot}.\n" if @current_spot
      puts self

      if @game_type == "1"
        puts "\nPlease select your spot."
        get_human_spot(@current_player)
        get_comp_spot
      elsif @game_type == "2"
        switch_player
        puts "\nIt is now Player '#{@current_player}'s turn."
        get_human_spot(@current_player)
      else
        switch_player
        print "\nPlayer '#{@current_player}' is moving"
        sleep(1)
        print "."
        sleep(2)
        print "."
        sleep(2)
        print "."
        sleep(1)
        get_comp_spot
      end
      system("clear")
    end

    puts "-----------"
    puts "Player 1: '#{@player_1}'"
    puts "Player 2: '#{@player_2}'"
    puts "-----------"

    if tie(@board)
      puts "\nGame over. Player '#{@player_1}' and player '#{@player_2}' have tied."
    else
      puts "\nGame over. Player #{@winner} has won!"
    end

    puts self
  end

  private

  def switch_player
    if @current_player == @player_1
      @current_player = @player_2
    else
      @current_player = @player_1
    end
  end

  def next_player
    if @current_player == @player_1
      @player_2
    else
      @player_1
    end
  end

  def get_game_type
    @game_type = gets.chomp

    until @game_type == "1" || @game_type == "2" || @game_type == "3"
      puts "Invalid input; please choose options 1, 2, or 3."
      @game_type = gets.chomp
    end
  end

  def get_marker
    @player_1 = gets.chomp.upcase!

    until @player_1 == "X" || @player_1 == "O"
      puts "Invalid input; select to play as either 'X' or 'O'."
      @player_1 = gets.chomp.upcase!
    end

    @player_1 == 'X' ? @player_2 = 'O' : @player_2 = 'X'
  end

  def get_human_spot(player)
    end_of_turn = false
    until end_of_turn
      spot = gets.chomp
      if Array("a".."z").include?(spot) || !@board.include?(spot.to_i)
        system("clear")
        puts "Invalid input; please select an unoccupied spot.\n"
        puts self
      else
        @board[spot.to_i - 1] = player
        @current_spot = spot
        end_of_turn = true
      end
    end

  end

  def get_comp_spot
    if @board[4] == "5"
      @board[4] = @current_player
    else
      spot_index = get_best_move(@board)
      @board[spot_index] = @current_player
      @current_spot = spot_index + 1
    end
  end

  def get_best_move(board)
    available_spots = board.select { |spot| spot unless spot == @player_2 || spot == @player_1 }
    best_move = nil

    available_spots.each do |spot|
      spot_index = (spot.to_i - 1)
      board[spot_index] = @current_player

      if game_is_over(board)
        best_move = spot_index
        board[spot_index] = spot
        @winner = @current_player
        return best_move
      else
        board[spot_index] = next_player
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
      return available_spots.sample.to_i - 1
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
