require 'colorize'

class Display
  class << self
    def instructions
      system("clear")
      puts "_____ ___  __  _____     __  _____  __  ____".colorize(:light_blue )
      puts "  |    |  |      |  /\\  |      |   |  | |--".colorize(:light_blue )
      puts "  |   _|_ \\__    | /--\\ \\__    |   \\__/ |___".colorize(:light_blue )
      puts "\n"
      puts "Welcome to Tic Tac Toe!"
      puts "First player to get three in a row wins."
    end

    def header(game)
      system("clear")
      puts "-----------"
      if game.type == "1"
        puts "Player: '#{game.player_1.marker}'"
        puts "Computer: '#{game.player_2.marker}'"
      else
        puts "Player 1: '#{game.player_1.marker}'"
        puts "Player 2: '#{game.player_2.marker}'"
      end
      puts "-----------"
    end

    def gaming_options
      puts "Choose from the following gaming options (1, 2, or 3)."
      puts "\n[ 1 ] Player vs. Computer"
      puts "[ 2 ] Player vs. Player"
      puts "[ 3 ] Computer vs. Computer"
      puts "\n"
    end

    def first_turn_options(player)
      system("clear")
      puts "-----------"
      puts "Player 1 will be #{player.marker}."
      puts "Please choose who goes first. Enter 'X' or 'O'."
      puts "-----------"
      puts "\n"
    end

    def last_move(current_player, last_move)
      puts "\nPlayer '#{current_player.marker}' moved to position #{last_move}.\n" if last_move
    end

    def next_turn(current_player)
      if current_player.type == "computer"
        print "\nPlayer '#{current_player.marker}' is looking for next move"
        counter
      else
        puts "\nIt is now Player '#{current_player.marker}'s turn."
      end
    end

    def counter
      sleep(1)
      print "."
      sleep(1)
      print "."
      sleep(1)
      print "."
      sleep(1)
    end

    def final_score(game)
      if game.board.all_spots_taken?
        puts "\nGame over. Player '#{game.player_1.marker}' and player '#{game.player_2.marker}' have tied.".colorize(:light_blue )
      else
        puts "\nGame over. Player '#{game.winner.marker}' has won!".colorize(:light_blue )
      end
      Display.board(game.board.spots)
      puts "\n"
      puts "Press any key to start a new game."
    end

    def error_message(number)
      case number
      when 1
        puts "Invalid input; please choose options 1, 2, or 3.".colorize(:red )
      when 2
        puts "Invalid input; please select either 'X' or 'O'.".colorize(:red )
      when 3
        puts "Invalid input; please select an unoccupied spot.\n".colorize(:red )
      end
    end

    def marker_options(number)
      system("clear")
      puts "-----------"
      case number
      when 1
        puts "You chose Player vs. Computer."
        puts "Choose to play as either 'X' or 'O'."
      when 2
        puts "You chose Player vs. Player."
        puts "Player 1, choose to play as either 'X' or 'O'."
      when 3
        puts "You chose Computer vs. Computer."
        puts "Please choose either 'X' or 'O' for Player 1."
      end
      puts "-----------"
      puts "\n"
    end

    def board(spots)
      puts " _________________\n|     |     |     |\n|  #{spots[0]}  |  #{spots[1]}  |  #{spots[2]}  |\n|_____|_____|_____|\n|     |     |     |\n|  #{spots[3]}  |  #{spots[4]}  |  #{spots[5]}  |\n|_____|_____|_____|\n|     |     |     |\n|  #{spots[6]}  |  #{spots[7]}  |  #{spots[8]}  |\n|_____|_____|_____|"
    end
  end
end