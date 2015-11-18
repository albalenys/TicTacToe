def instructions
  puts "_____ ___  __  _____     __  _____  __  ____"
  puts "  |    |  |      |  /\\  |      |   |  | |--"
  puts "  |   _|_ \\__    | /--\\ \\__    |   \\__/ |___"
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

def counter
  sleep(1)
  print "."
  sleep(1)
  print "."
  sleep(1)
  print "."
  sleep(1)
end

def end_game_text
  if Game.is_tied?(game.board)
    puts "\nGame over. Player '#{game.player_1.marker}' and player '#{game.player_2.marker}' have tied."
  else
    puts "\nGame over. Player '#{game.winner.marker}' has won!"
  end
  puts game
  puts "\n"
end