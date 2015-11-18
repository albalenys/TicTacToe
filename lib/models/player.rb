class Player
  attr_accessor :marker
  attr_reader :type

  def initialize(type)
    @marker =  nil
    @type = type
  end

  def get_marker(next_player)
    self.marker = gets.chomp.upcase!

    until (self.marker == "X" || self.marker == "O")
      puts "Invalid input; select to play as either 'X' or 'O'."
      self.marker = gets.chomp.upcase!
    end

    self.marker == 'X' ? next_player.marker = 'O' : next_player.marker = 'X'
  end

  def get_move(board)
    if self.type == "human"
      spot = gets.chomp

      until spot == !(Array("a".."z").include?(spot)) || board.include?(spot.to_i)
        puts "Invalid input; please select an unoccupied spot.\n"
        spot = gets.chomp
      end

      spot_index = spot.to_i - 1
      board[spot_index] = self.marker
      return spot
    else
      return best_move(board)
    end
  end

  private

  def best_move(board)
    available_spots = board.select { |spot| spot unless spot == 'X' || spot == 'O' }
    move = nil

    available_spots.each do |spot|
      spot_index = spot - 1
      board[spot_index] = self.marker
      if Game.is_over?(board)
        move = spot
        break
      else
        self.marker == 'X' ? board[spot_index] = 'O' : board[spot_index] = 'X'

        if Game.is_over?(board)
          board[spot_index] = self.marker
          move = spot
          break
        else
          board[spot_index] = spot
        end
      end
    end

    unless move
      if board[4] == 5
        board[4] = self.marker
        move = 5
      else
        spot = available_spots.sample
        board[spot.to_i - 1] = self.marker
        move = spot
      end
    end

    return move
  end
end