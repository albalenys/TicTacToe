def header
  puts "-----------"
  if @game_type == "1"
    puts "Player: '#{@player_1.marker}'"
    puts "Computer: '#{@player_2.marker}'"
  else
    puts "Player 1: '#{@player_1.marker}'"
    puts "Player 2: '#{@player_2.marker}'"
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