class Player
  attr_accessor :marker, :type

  def initialize
    @marker =  nil
    @type = nil
  end

  def get_marker
    self.marker = gets.chomp.upcase!

    until (self.marker == "X" || self.marker == "O")
      puts "Invalid input; select to play as either 'X' or 'O'."
      self.marker = gets.chomp.upcase!
    end
  end

  def get_move(board, current_player, last_move)
    if self.type = "human"
      spot = gets.chomp

      until spot == !(Array("a".."z").include?(spot)) || board.include?(spot.to_i)
        puts "Invalid input; please select an unoccupied spot.\n"
        spot = gets.chomp
      end

      spot_index = spot.to_i - 1
      board[spot_index] = current_player.marker
      last_move = spot
    else
      if board[4] == 5
        board[4] = current_player.marker
        last_move = 5
      else
        last_move = best_move(board, current_player)
      end
    end
  end

  def best_move(board, current_player)
    available_spots = board.select { |spot| spot unless spot == @player_1.marker || spot == @player_2.marker }
    best_move = nil

    available_spots.each do |spot|
      spot_index = spot - 1
      board[spot_index] = current_player.marker
      if game_is_over?
        best_move = spot
        break
      else
        board[spot_index] = next_player.marker
        if game_is_over?
          board[spot_index] = current_player.marker
          best_move = spot
          break
        else
          board[spot_index] = spot
        end
      end
    end

    unless best_move
      spot = available_spots.sample
      best_move = spot
      board[spot.to_i - 1] = current_player.marker
    end

    best_move
  end
end