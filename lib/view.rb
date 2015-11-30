require 'colorize'

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

def gaming_options_text
  puts "Choose from the following gaming options (1, 2, or 3)."
  puts "\n[ 1 ] Player vs. Computer"
  puts "[ 2 ] Player vs. Player"
  puts "[ 3 ] Computer vs. Computer"
  puts "\n"
end

def first_turn_options_text(game)
  system("clear")
  puts "-----------"
  puts "Player 1 will be #{game.player_1.marker}."
  puts "Please choose who goes first. Enter 'X' or 'O'."
  puts "-----------"
  puts "\n"
end

def next_turn_text(game)
  if game.current_player.type == "computer"
    print "\nPlayer '#{game.current_player.marker}' is looking for next move"
    counter
  else
    puts "\nIt is now Player '#{game.current_player.marker}'s turn."
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

def end_game_text(game)
  if game.board.is_tied?
    puts "\nGame over. Player '#{game.player_1.marker}' and player '#{game.player_2.marker}' have tied.".colorize(:light_blue )
  else
    puts "\nGame over. Player '#{game.winner.marker}' has won!".colorize(:light_blue )
  end
  puts game.board
  puts "\n"
end