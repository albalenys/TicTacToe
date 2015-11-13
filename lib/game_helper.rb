def header
  puts "-----------"
  if @game_type == "1"
    puts "Player: '#{@player_1}'"
    puts "Computer: '#{@player_2}'"
  else
    puts "Player 1: '#{@player_1}'"
    puts "Player 2: '#{@player_2}'"
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