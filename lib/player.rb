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
    board_array = board.spots
    @type == "human" ? human_move(board) : computer_move(board)
  end

  private

  def human_move(board)
    board_array = board.spots
    spot = gets.chomp

    until spot == !(Array("a".."z").include?(spot)) || board_array.include?(spot.to_i)
      Display.error_message(3)
      spot = gets.chomp
    end

    spot_index = spot.to_i - 1
    board_array[spot_index] = @marker
    return spot
  end

  def computer_move(board)
    board_array = board.spots
    available_spots = board_array.select { |spot| spot unless spot == 'X' || spot == 'O' }
    move = nil

    available_spots.each do |spot|
      spot_index = spot - 1
      board_array[spot_index] = @marker
      if board.three_in_row?
        move = spot
        break
      else
        @marker == 'X' ? board_array[spot_index] = 'O' : board_array[spot_index] = 'X'

        if board.three_in_row?
          board_array[spot_index] = @marker
          move = spot
          break
        else
          board_array[spot_index] = spot
        end
      end
    end

    unless move
      if board_array[4] == 5
        board_array[4] = @marker
        move = 5
      else
        spot = available_spots.sample
        board_array[spot.to_i - 1] = @marker
        move = spot
      end
    end

    return move
  end
end