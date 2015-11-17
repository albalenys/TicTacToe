class Player
  attr_accessor :marker, :type

  def initialize(type)
    @marker =  nil
    @type = type
  end

  def get_marker
    self.marker = gets.chomp.upcase!

    until (self.marker == "X" || self.marker == "O")
      puts "Invalid input; select to play as either 'X' or 'O'."
      self.marker = gets.chomp.upcase!
    end
  end

  def get_move(board, last_move)
    if self.type == "human"
      spot = gets.chomp
      until spot == !(Array("a".."z").include?(spot)) || board.include?(spot.to_i)
        puts "Invalid input; please select an unoccupied spot.\n"
        spot = gets.chomp
      end
      spot_index = spot.to_i - 1
      board[spot_index] = self.marker
      last_move = spot
    else
      if board[4] == 5
        board[4] = self.marker
        last_move = 5
      else
        last_move = best_move(board)
      end
    end
  end

  def best_move(board)
    available_spots = board.select { |spot| spot unless spot == 'X' || spot == 'O' }
    move = nil

    available_spots.each do |spot|
      spot_index = spot - 1
      board[spot_index] = self.marker
      if Game.game_is_over?(board)
        move = spot
        break
      else
        if self.marker == 'X'
          board[spot_index] = 'O'
        else
          board[spot_index] = 'X'
        end

        if Game.game_is_over?(board)
          board[spot_index] = self.marker
          move = spot
          break
        else
          board[spot_index] = spot
        end
      end
    end

    unless move
      spot = available_spots.sample
      move = spot
      board[spot.to_i - 1] = self.marker
    end

    move
  end
end