class Player
  attr_accessor :marker, :input
  attr_reader :type

  def initialize(type)
    @marker =  nil
    @type = type
  end

  def get_marker(next_player)
    @marker = gets.chomp.upcase!
    until (@marker == "X" || @marker == "O")
      Display.error_message(2)
      @marker = gets.chomp.upcase!
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
    spot
  end

  def computer_move(board)
    if check_condition(board) || check_condition("win", board)
      spot = check_condition(board) || check_condition("win", board)
    elsif board.spots[4] == 5
      spot = 5
    else
      spot = board.available_spots.sample
    end
    board.spots[index(spot)] = @marker
    spot
  end

  def check_condition(condition = "lost", board)
    board.available_spots.each do |spot|
      if condition == "lost"
        @marker == 'X' ? board.spots[index(spot)] = 'O' : board.spots[index(spot)] = 'X'
      else
        board.spots[index(spot)] = @marker
      end

      @move = spot if board.three_in_row?
      board.spots[index(spot)] = spot
      break if board.three_in_row?
    end
    @move ||= nil
  end
end