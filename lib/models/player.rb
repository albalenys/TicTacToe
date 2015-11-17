class Player
  attr_accessor :marker

  def initialize
    @marker =  nil
  end

  def get_marker
    self.marker = gets.chomp.upcase!

    until (self.marker == "X" || self.marker == "O")
      puts "Invalid input; select to play as either 'X' or 'O'."
      self.marker = gets.chomp.upcase!
    end
  end

  def get_human_spot(board, current_player, last_move, winner)
    spot = gets.chomp

    until spot == !(Array("a".."z").include?(spot)) || board.include?(spot.to_i)
      puts "Invalid input; please select an unoccupied spot.\n"
      spot = gets.chomp
    end

    spot_index = spot.to_i - 1
    board[spot_index] = current_player.marker
    last_move = spot
  end
end