require_relative 'helpers'
require 'pry'

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
    if check_for_win(board)
      spot = check_for_win(board)
    elsif check_for_lost(board)
      spot = check_for_lost(board)
    elsif board.spots[4] == 5
      spot = 5
    else
      spot = board.available_spots.sample
    end
    board.spots[index(spot)] = @marker
    return spot
  end

  def check_for_win(board)
    move = nil
    board.available_spots.each do |spot|
      board.spots[index(spot)] = @marker
      if board.three_in_row?
        board.spots[index(spot)] = spot
        move = spot
        break
      else
        board.spots[index(spot)] = spot
      end
    end
    return move
  end

  def check_for_lost(board)
    move = nil
    board.available_spots.each do |spot|
      @marker == 'X' ? board.spots[index(spot)] = 'O' : board.spots[index(spot)] = 'X'
      if board.three_in_row?
        board.spots[index(spot)] = spot
        move = spot
        break
      else
        board.spots[index(spot)] = spot
      end
    end
    return move
  end
end