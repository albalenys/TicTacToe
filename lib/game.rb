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
    puts "Choose from the following gaming options."
    puts "\n[ 1 ] Player vs. Computer"
    puts "[ 2 ] Player vs. Player"
    puts "[ 3 ] Computer vs. Computer"
    puts "\n"
    get_game_type
    system("clear")

    puts "-----------"
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
    puts "-----------"
    puts "\n"
    get_marker
    system("clear")

    puts "-----------"
    puts "Player 1 will be #{@player_1}."
    puts "Please choose who goes first. Enter 'X' or 'O'."
    puts "-----------"
    puts "\n"
    get_first_player_turn
    system("clear")

    until (game_is_over? || game_is_tied?)
      puts "-----------"
      if @game_type == "1"
        puts "Player: '#{@player_1}'"
        puts "Computer: '#{@player_2}'"
      else
        puts "Player 1: '#{@player_1}'"
        puts "Player 2: '#{@player_2}'"
      end
      puts "-----------"
      puts "\nPlayer '#{@current_player}' moved to position #{@last_move}.\n" if @last_move
      puts self
      switch_player
      puts "\nIt is now Player '#{@current_player}'s turn."

      if @game_type == "1"
        if @current_player == @player_2
          print "Player '#{@current_player}' is looking for next move"
          sleep(1)
          print "."
          sleep(1)
          print "."
          sleep(1)
          print "."
          sleep(1)
        end
        @current_player == @player_1 ? get_human_spot : get_comp_spot
      elsif @game_type == "2"
        get_human_spot
      else
        print "\nPlayer '#{@current_player}' is moving"
        sleep(1)
        print "."
        sleep(1)
        print "."
        sleep(1)
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

    if game_is_tied?
      puts "\nGame over. Player '#{@player_1}' and player '#{@player_2}' have tied."
    else
      puts "\nGame over. Player '#{@winner}' has won!"
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

  def next_player
    @current_player == @player_1 ? @player_2 : @player_1
  end

  def get_game_type
    @game_type = gets.chomp

    until (@game_type == "1" || @game_type == "2" || @game_type == "3")
      puts "Invalid input; please choose options 1, 2, or 3."
      @game_type = gets.chomp
    end
  end

  def get_marker
    @player_1 = gets.chomp.upcase!

    until (@player_1 == "X" || @player_1 == "O")
      puts "Invalid input; select to play as either 'X' or 'O'."
      @player_1 = gets.chomp.upcase!
    end

    @player_1 == 'X' ? @player_2 = 'O' : @player_2 = 'X'
  end

  def get_first_player_turn
    @current_player = gets.chomp.upcase!

    until (@current_player == "X" || @current_player == "O")
      puts "Invalid input; please select either 'X' or 'O'."
      @current_player = gets.chomp.upcase!
    end

    switch_player
  end

  def get_human_spot
    end_of_turn = false
    until end_of_turn
      spot = gets.chomp
      if Array("a".."z").include?(spot) || !@board.include?(spot.to_i)
        puts "Invalid input; please select an unoccupied spot.\n"
      else
        @board[spot.to_i - 1] = @current_player
        @last_move = spot
        @winner = @current_player if game_is_over?
        end_of_turn = true
      end
    end
  end

  def get_comp_spot
    if @board[4] == 5
      @board[4] = @current_player
      @last_move = 5
    else
      @last_move = get_best_move
    end
  end

  def get_best_move
    available_spots = @board.select { |spot| spot unless spot == @player_2 || spot == @player_1 }
    best_move = nil

    available_spots.each do |spot|
      spot_index = spot - 1
      @board[spot_index] = @current_player
      if game_is_over?
        @winner = @current_player
        best_move = spot
        return best_move
      else
        @board[spot_index] = next_player
        if game_is_over?
          @board[spot_index] = @current_player
          best_move = spot
          return best_move
        else
          @board[spot_index] = spot
        end
      end
    end

    unless best_move
      spot = available_spots.sample
      best_move = spot
      @board[spot.to_i - 1] = @current_player
    end

    best_move
  end

  def game_is_over?
    [@board[0], @board[1], @board[2]].uniq.length == 1 ||
    [@board[3], @board[4], @board[5]].uniq.length == 1 ||
    [@board[6], @board[7], @board[8]].uniq.length == 1 ||
    [@board[0], @board[3], @board[6]].uniq.length == 1 ||
    [@board[1], @board[4], @board[7]].uniq.length == 1 ||
    [@board[2], @board[5], @board[8]].uniq.length == 1 ||
    [@board[0], @board[4], @board[8]].uniq.length == 1 ||
    [@board[2], @board[4], @board[6]].uniq.length == 1
  end

  def game_is_tied?
    @board.all? { |spots| spots == @player_2 || spots == @player_1 }
  end

  def to_s
    " _________________\n|     |     |     |\n|  #{@board[0]}  |  #{@board[1]}  |  #{@board[2]}  |\n|_____|_____|_____|\n|     |     |     |\n|  #{@board[3]}  |  #{@board[4]}  |  #{@board[5]}  |\n|_____|_____|_____|\n|     |     |     |\n|  #{@board[6]}  |  #{@board[7]}  |  #{@board[8]}  |\n|_____|_____|_____|"
  end

end

# game = Game.new
# game.start_game
