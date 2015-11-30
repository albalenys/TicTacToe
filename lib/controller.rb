require_relative 'view'
require_relative 'models/game'
require_relative 'models/player'
require_relative 'models/board'

game = Game.new
instructions
gaming_options_text
game.get_type
system("clear")
puts "-----------"
game.create_players
puts "-----------"
puts "\n"
game.player_1.get_marker(game.player_2)
first_turn_options_text(game)
game.get_first_player_turn
system("clear")

until (game.board.is_over? || game.board.is_tied?)
  header(game)
  puts "\nPlayer '#{game.current_player.marker}' moved to position #{game.last_move}.\n" if game.last_move
  puts game.board
  game.switch_player
  next_turn_text(game)
  game.last_move = game.current_player.get_move(game.board.spots)
  game.winner = game.current_player if game.board.is_over?
  system("clear")
end

header(game)
end_game_text(game)