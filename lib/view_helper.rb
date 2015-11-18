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

def counter
  sleep(1)
  print "."
  sleep(1)
  print "."
  sleep(1)
  print "."
  sleep(1)
end