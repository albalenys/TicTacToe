require_relative 'view'
require_relative 'models/game'
require_relative 'models/player'

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

until (Game.is_over?(game.board) || Game.is_tied?(game.board))
  header(game)
  puts "\nPlayer '#{game.current_player.marker}' moved to position #{game.last_move}.\n" if game.last_move
  puts game
  game.switch_player
  next_turn_text(game)
  game.last_move = game.current_player.get_move(game.board)
  game.winner = game.current_player if Game.is_over?(game.board)
  system("clear")
end

header(game)
end_game_text(game)