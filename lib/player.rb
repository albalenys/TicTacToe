require_relative 'helpers'

class Player
  attr_accessor :marker, :input
  attr_reader :type

  def initialize(type)
    @marker =  nil
    @type = type
    self.input = $stdin
  end

  def get_marker(next_player)
    @marker = input.gets.chomp.upcase!
    until (@marker == "X" || @marker == "O")
      Display.error_message(2)
      @marker = input.gets.chomp.upcase!
    end
    @marker == 'X' ? next_player.marker = 'O' : next_player.marker = 'X'
  end

  def get_move(board)
    @type == "human" ? human_move(board) : computer_move(board)
  end

  private

  def human_move(board)
    spot = gets.chomp
    until spot == !(Array("a".."z").include?(spot)) || board.spots.include?(spot.to_i)
      Display.error_message(3)
      spot = gets.chomp
    end
    board.spots[index(spot)] = @marker
    return spot
  end

  def computer_move(board)
    if best_move(board)
      return best_move(board)
    elsif board.spots[4] == 5
      board.spots[4] = @marker
      return 5
    else
      return pick_random_spot(board)
    end
  end

  def best_move(board)
    move = nil
    board.available_spots.each do |spot|
      board.spots[index(spot)] = @marker
      if board.three_in_row?
        move = spot
        return move
      else
        avoid_lose(board, spot)
      end
    end
    return move
  end

  def pick_random_spot(board)
    spot = board.available_spots.sample
    board.spots[index(spot)] = @marker
    return spot
  end

  def avoid_lose(board, spot)
    @marker == 'X' ? board.spots[index(spot)] = 'O' : board.spots[index(spot)] = 'X'
    if board.three_in_row?
      board.spots[index(spot)] = @marker
      return spot
    else
      board.spots[index(spot)] = spot
    end
  end

end