class Board
  attr_accessor :spots

  def initialize
    @spots = Array(1..9)
  end

  def three_in_row?
    [@spots[0], @spots[1], @spots[2]].uniq.length == 1 ||
    [@spots[3], @spots[4], @spots[5]].uniq.length == 1 ||
    [@spots[6], @spots[7], @spots[8]].uniq.length == 1 ||
    [@spots[0], @spots[3], @spots[6]].uniq.length == 1 ||
    [@spots[1], @spots[4], @spots[7]].uniq.length == 1 ||
    [@spots[2], @spots[5], @spots[8]].uniq.length == 1 ||
    [@spots[0], @spots[4], @spots[8]].uniq.length == 1 ||
    [@spots[2], @spots[4], @spots[6]].uniq.length == 1
  end

  def all_spots_taken?
    @spots.all? { |spots| spots == 'X' || spots == 'O' }
  end
end