require_relative 'view_helper'
require_relative 'models/game'
require_relative 'models/player'

game = Game.new
system("clear")
puts "_____ ___  __  _____     __  _____  __  ____"
puts "  |    |  |      |  /\\  |      |   |  | |--"
puts "  |   _|_ \\__    | /--\\ \\__    |   \\__/ |___"
puts "\n"
puts "Welcome to Tic Tac Toe!"
puts "First player to get three in a row wins."
puts "Choose from the following gaming options (1, 2, or 3)."
puts "\n[ 1 ] Player vs. Computer"
puts "[ 2 ] Player vs. Player"
puts "[ 3 ] Computer vs. Computer"
puts "\n"
game.get_type
system("clear")

puts "-----------"
if @game_type == "1"
  puts "You chose Player vs. Computer."
  game.player_1 = Player.new("human")
  game.player_2 = Player.new("computer")
  puts "Choose to play as either 'X' or 'O'."
elsif @game_type == "2"
  puts "You chose Player vs. Player."
  puts "Player 1, choose to play as either 'X' or 'O'."
  game.player_1 = Player.new("human")
  game.player_2 = Player.new("human")
else
  puts "You chose Computer vs. Computer."
  puts "Please choose either 'X' or 'O' for Player 1."
  game.player_1 = Player.new("computer")
  game.player_2 = Player.new("computer")
end

puts "-----------"
puts "\n"
game.player_1.get_marker
game.player_1.marker == 'X' ? game.player_2.marker = 'O' : game.player_2.marker = 'X'
system("clear")

puts "-----------"
puts "Player 1 will be #{game.player_1.marker}."
puts "Please choose who goes first. Enter 'X' or 'O'."
puts "-----------"
puts "\n"
game.get_first_player_turn
system("clear")

until (Game.is_over?(game.board) || Game.is_tied?(game.board))
  header(game)
  puts "\nPlayer '#{game.current_player.marker}' moved to position #{game.last_move}.\n" if game.last_move
  puts game
  game.switch_player
  puts "\nIt is now Player '#{game.current_player.marker}'s turn."

  if game.current_player.type == "computer"
    print "Player '#{game.current_player.marker}' is looking for next move"
    counter
  end
  game.current_player.get_move(game.board, game.last_move)
  game.winner = game.current_player if Game.is_over?(game.board)
  system("clear")
end

header(game)
if Game.is_tied?(game.board)
  puts "\nGame over. Player '#{game.player_1.marker}' and player '#{game.player_2.marker}' have tied."
else
  puts "\nGame over. Player '#{game.winner.marker}' has won!"
end
puts game
puts "\n"